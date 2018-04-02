require 'factory_girl'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
require 'vcr'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.include FactoryGirl::Syntax::Methods

  config.extend VCR::RSpec::Macros

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
