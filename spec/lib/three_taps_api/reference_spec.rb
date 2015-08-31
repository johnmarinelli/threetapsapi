require_relative '../../spec_helper'

describe ThreeTapsAPI::Reference do
  describe 'default attributes' do
    it 'must have base URL set to reference.3taps endpoint' do
      ThreeTapsAPI::Reference.base_uri.must_equal 'http://reference.3taps.com'
    end
  end

  describe 'GET reference results for category groups' do
    before do
      VCR.insert_cassette 'category_group_reference', :record => :new_episodes
      @reference = ThreeTapsAPI::Reference.new
    end

    after do
      VCR.eject_cassette
    end

    it 'records category groups fixture' do
      @reference.category_groups
    end
  end

  describe 'GET reference results for categories' do
    before do
      VCR.insert_cassette 'category_reference', :record => :new_episodes
      @reference = ThreeTapsAPI::Reference.new
    end

    after do
      VCR.eject_cassette
    end

    it 'records categories fixture' do
      @reference.categories
    end
  end

  describe 'GET reference results for country locations' do
    before do
      VCR.insert_cassette 'location_country_reference', :record => :new_episodes
      @reference = ThreeTapsAPI::Reference.new
    end

    after do
      VCR.eject_cassette
    end
    
    it 'records locations fixture' do
      @reference.locations 'country'
    end
  end
  
  describe 'GET reference results for zipcode locations' do
    before do
      VCR.insert_cassette 'location_zipcode_reference', :record => :new_episodes
      @reference = ThreeTapsAPI::Reference.new
    end

    after do
      VCR.eject_cassette
    end

    it 'records zipcodes fixture' do
      @reference.locations 'zipcode'
    end
  end
  
  describe 'GET reference results for invalid location level' do
    before do
      VCR.insert_cassette 'invalid_reference', :record => :new_episodes
      @reference = ThreeTapsAPI::Reference.new
    end

    after do
      VCR.eject_cassette
    end

    it 'has nil reference when given an invalid location level' do
      @reference.locations 'invalid'
      @reference.reference.must_equal nil
    end
  end
end
