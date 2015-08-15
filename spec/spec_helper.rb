require_relative '../lib/three_taps_api'

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

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/three_taps_cassettes'
  c.hook_into :webmock
end
