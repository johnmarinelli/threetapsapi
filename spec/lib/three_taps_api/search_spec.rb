require_relative '../../spec_helper'

describe ThreeTapsAPI::Search do
  describe 'default attributes' do
    it 'must have base URL set to search.3taps endpoint' do
      ThreeTapsAPI::Search.base_uri.must_equal 'http://search.3taps.com'
    end
  end

  describe 'GET search results' do
    before do 
      VCR.insert_cassette 'search', :record => :new_episodes
      @searcher = ThreeTapsAPI::Search.new
      @searcher.search
    end
    
    it 'records a search fixture' do
      # Uncomment this line if it's your first time running
      # This line has VCR gem record the result from a single search
      ThreeTapsAPI::Search.new.search
    end

    after do
      VCR.eject_cassette
    end

    it 'Must have a search method' do
      @searcher.must_respond_to :search
    end

    it 'Must parse the API response from JSON to hash' do 
      @searcher.results.must_be_instance_of Hash
    end

    it 'Must perform the request and get the data' do 
      @searcher.results.response.must_be_instance_of Net::HTTPOK
    end

    it 'Must parse the postings from JSON to array' do
      @searcher.postings.must_be_instance_of Array
    end

    it 'Must have postings stored inside of searcher' do
      @searcher.postings.count.must_be :>, 0
    end

    it 'Must keep postings stored as open structs' do
      first = @searcher.postings.first
      first.must_be_instance_of OpenStruct
      first.location.must_be_instance_of OpenStruct
    end
  end

end
