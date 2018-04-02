VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr/cassettes'
  config.hook_into :webmock
end