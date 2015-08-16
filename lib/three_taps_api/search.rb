require_relative 'base'

module ThreeTapsAPI
  class Search < Base
    base_uri 'search.3taps.com'
    attr_reader :postings
    attr_reader :parameters
    attr_accessor :location

    def create_getter_and_setter(name)
      get = Proc.new { instance_variable_get "@#{name}" }
      set = Proc.new { |val| instance_variable_set "@#{name}", val; @parameters[name.to_sym] = val }
      self.class.send :define_method, "#{name}", get
      self.class.send :define_method, "#{name}=", set
    end

    def initialize(args = {})
      @parameters = args
      @location = Location.new args[:location]
      @postings = OpenStruct.new

      args.delete :location

      args.each do |k, v|
        create_getter_and_setter k
        self.send "#{k.to_s}=", v
      end
    end

    def search(opts = {})
      opts.merge!(auth_token_hash)
        .merge!(@parameters)
      @results = self.class.get self.class.base_uri, { query: opts }
      @postings = @results.parsed_response['postings'].map { |p| ThreeTapsAPI.rec_hash_to_openstruct p }
    end

    def method_missing(name, *args, &block)
      # TODO: if it's a valid parameter, create a get/set for it
      name = name.to_s.chop if name.to_s.reverse[0] == '='
      @parameters[name.to_sym] = args[0]
      create_getter_and_setter name
      self.send "#{name.to_s}=".to_sym, args[0]
    end
  end
end
