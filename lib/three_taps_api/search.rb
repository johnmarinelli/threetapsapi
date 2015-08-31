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
      @location = Location.new(args.delete(:location) || {})
      @postings = OpenStruct.new

      args.each do |k, v|
        create_getter_and_setter k if ThreeTapsAPI.valid_parameter? k.to_s
        self.send "#{k.to_s}=", v
      end 
    end

    def search
      opts = {}
      opts.merge!(auth_token_hash)
        .merge!(@parameters)
        .merge!(@location.to_query_hash)
      @results = self.class.get self.class.base_uri, { query: opts }
      @postings = @results.parsed_response['postings'].map { |p| ThreeTapsAPI.rec_hash_to_openstruct p }
    end

    def method_missing(name, *args, &block)
      name = name.to_s.chop if name.to_s.reverse[0] == '='
      p "#{name} is not a valid parameter." and return if ThreeTapsAPI.invalid_parameter? name
      @parameters[name.to_sym] = args[0]
      create_getter_and_setter name
      self.send "#{name.to_s}=".to_sym, args[0]
    end
  end
end
