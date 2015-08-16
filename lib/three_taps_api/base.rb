require_relative 'location'

module ThreeTapsAPI
  def self.rec_hash_to_openstruct(hash)
    hash = hash.map { |k, v| [k, v.is_a?(Hash) ? rec_hash_to_openstruct(v) : v] }
    OpenStruct.new Hash[hash]
  end

  class Base
    include HTTParty
    base_uri '3taps.com'
    @@api_key = ENV['THREE_TAPS_API_KEY']
    attr_reader :results

    def self.api_key
      @@api_key
    end

    def auth_token_hash
      { auth_token: self.class.api_key }
    end

  end
end