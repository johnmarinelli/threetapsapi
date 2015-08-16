require_relative 'base'

module ThreeTapsAPI
  class Reference < Base
    base_uri 'reference.3taps.com'

    def locations(level)
      uri = self.class.base_uri + '/locations'
      @reference = self.class.get uri, { query: auth_token_hash.merge({ level: level }) }
    end

    def method_missing(name, *args, &block) 
      uri = self.class.base_uri + "/#{name.to_s}"
      @reference = self.class.get uri, { query: auth_token_hash }

      # if it's a valid request,
      # create a get/setter for it
    end
  end
end
