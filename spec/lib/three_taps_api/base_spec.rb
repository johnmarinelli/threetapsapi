require_relative '../../spec_helper'

describe ThreeTapsAPI::Base do
  describe 'default attributes' do
    it 'must have an api key set' do
      ThreeTapsAPI::Base.api_key.wont_be_empty
    end

    it 'Must include httparty' do
      ThreeTapsAPI::Base.must_include HTTParty
    end

    it 'must have base URL set to 3taps endpoint' do
      ThreeTapsAPI::Base.base_uri.must_equal 'http://3taps.com'
    end
  end

  describe 'recursive hash to openstruct' do
    it 'must make all subhashes into openstructs' do
      h = {
        a: 1,
        b: {
          c: 2
        },
        d: {
          e: {
            f: 3
          }
        }
      }

      h = ThreeTapsAPI.rec_hash_to_openstruct h
      h.a.must_equal 1
      h.b.c.must_equal 2
      h.d.e.f.must_equal 3

      h.a.must_be_instance_of Fixnum
      h.b.must_be_instance_of OpenStruct
      h.b.c.must_be_instance_of Fixnum
      h.d.must_be_instance_of OpenStruct
      h.d.e.must_be_instance_of OpenStruct
      h.d.e.f.must_be_instance_of Fixnum
    end
  end

  describe 'recursively stringify hash keys' do
    it 'must make all hash keys strings' do
      h = {
        a: 1,
        b: {
          c: 2
        },
        d: {
          e: {
            f: 3
          }
        }
      }

      h = ThreeTapsAPI.rec_stringify_hash_keys h
      h.each do |k, v|
        k.must_be_instance_of String
      end
      h['b']['c'].must_equal 2
      h['d']['e']['f'].must_equal 3
    end
  end
end
