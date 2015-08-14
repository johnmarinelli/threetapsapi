require 'httparty'

# Require every file in lib/api
Dir[File.dirname(__FILE__) + '/api/*.rb'].each do |file|
  require file
end
