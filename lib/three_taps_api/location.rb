module ThreeTapsAPI
  # Class for describing the 3taps location in an API-specific way
  class Location
    # Add more attributes as they are tested
    attr_accessor :country, :zipcode

    def initialize(args)
      args.each do |k, v|
        self.send "#{k}=", v if self.class.method_defined? "#{k}"
      end
    end
  end
end
