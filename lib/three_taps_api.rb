require 'httparty'

# Require every file in lib/api
Dir[File.dirname(__FILE__) + '/three_taps_api/*.rb'].each do |file|
  require file
end
