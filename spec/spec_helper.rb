require "lita-catme"
require "lita/rspec"
require 'coveralls'
require "uri"
require 'vcr'

Lita.version_3_compatibility_mode = false
Coveralls.wear!

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { allow_unused_http_interactions: false }
  config.configure_rspec_metadata!
end
