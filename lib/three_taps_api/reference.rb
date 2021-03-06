require_relative 'base'

module ThreeTapsAPI
  class Reference < Base
    base_uri 'reference.3taps.com'
    attr_reader :reference

    def locations(level)
      uri = self.class.base_uri + '/locations'
      @results = self.class.get uri, { query: auth_token_hash.merge({ level: level }) }

      begin
        parsed_response = ThreeTapsAPI.rec_hash_to_openstruct @results.parsed_response
        @reference = parsed_response.send "#{level.to_s}" if parsed_response.success
        p parsed_response.error if not parsed_response.sucess
      rescue TypeError
        p "ThreeTapsAPI::Reference.locations #{level.to_s}: rec_hash_to_openstruct not passed a hash"
      end 
    end

    def method_missing(name, *args, &block) 
      name = name.to_s
      p "#{name} is not a valid parameter." and return if ThreeTapsAPI.invalid_parameter? name
      uri = self.class.base_uri + "/#{name}"
      @results = self.class.get uri, { query: auth_token_hash }

      # if it's a valid request,
      # create a get/setter for it
      begin
        parsed_response = ThreeTapsAPI.rec_hash_to_openstruct @results.parsed_response
        @reference = parsed_response.send "#{name}" if parsed_response.success
      rescue TypeError
        p "ThreeTapsAPI::Reference.locations #{name}: rec_hash_to_openstruct not passed a hash"
      end
    end
  end
end
