require_relative '../../spec_helper'

describe ThreeTapsAPI::Search do
  describe 'default attributes' do
    it 'must have base URL set to search.3taps endpoint' do
      ThreeTapsAPI::Search.base_uri.must_equal 'http://search.3taps.com'
    end
  end

  describe 'instance variable metaprogramming' do
    it 'must be able to create instance variables on the fly' do
      s = ThreeTapsAPI::Search.new({ category_group: 'AAAA', location: { zipcode: 92001 } })
      s.category_group.must_equal 'AAAA'
      s.must_respond_to 'category_group='
      s.location.zipcode.must_equal 92001
      s.location.must_respond_to 'zipcode='
      s.category = 'Animals'
      s.category.must_equal 'Animals'
      s.must_respond_to :category=
    end

    it 'must recognize valid parameters' do
      ThreeTapsAPI.valid_parameters.each do |p|
        ThreeTapsAPI.valid_parameter?(p).must_equal true
      end
    end

    it 'must recognize invalid parameters' do
      ThreeTapsAPI.invalid_parameter?('yes').must_equal true
      ThreeTapsAPI.invalid_parameter?('bad').must_equal true
      ThreeTapsAPI.invalid_parameter?('gross').must_equal true
      ThreeTapsAPI.invalid_parameter?('').must_equal true
    end

    it 'must reject bad parameters' do
      s = ThreeTapsAPI::Search.new({ bad_key: 1, location: { zipcode: 92001 } })
      s.bad_key = 2
      s.bad_key.must_equal nil
      s.bad_key_two = 3
      s.bad_key_two.must_equal nil
    end
  end

  describe 'GET search results' do
    before do 
      VCR.insert_cassette 'search', :record => :new_episodes
      @searcher = ThreeTapsAPI::Search.new
      @searcher.search
    end

    after do
      VCR.eject_cassette
    end
    
    it 'records a search fixture' do
      # This line has VCR gem record the result from a single search
       ThreeTapsAPI::Search.new.search
    end

    it 'Must have a search method' do
      @searcher.must_respond_to :search
    end

    it 'Must parse the API response from JSON to hash' do 
      @searcher.results.must_be_instance_of Hash
    end

    it 'Must perform the request' do 
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

  describe 'GET search results with specific location and category group' do
    before do 
      VCR.insert_cassette 'search', :record => :new_episodes
      @searcher = ThreeTapsAPI::Search.new
      @searcher.category_group = 'AAAA'
      @searcher.location.zipcode = 'USA-92001'
    end

    it 'Records a search fixture with specific location and category group' do
      @searcher.search
    end
  end
end
