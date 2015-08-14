require_relative '../lib/api'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'turn'

# pretty print tests
Turn.config do |c|
  c.format = :outline
  # full backtrace
  c.trace = true
  c.natural = true
end

VCR.config do |c|
  c.cassette_library_dir = 'spec/fixtures/three_taps_cassettes'
  c.stub_with :webmock
end
