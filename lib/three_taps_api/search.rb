require_relative 'base'

module ThreeTapsAPI
  class Search < Base
    base_uri 'search.3taps.com'
    attr_reader :results, :postings

    def initialize(opts = {})
      @parameters = opts
    end

    def search(opts = {})
      opts.merge!({ auth_token: self.class.api_key })
        .merge!(@parameters)
      @results = self.class.get self.class.base_uri, { query: opts }
      @postings = @results.parsed_response['postings'].map { |p| ThreeTapsAPI.rec_hash_to_openstruct p }
    end
  end
end
