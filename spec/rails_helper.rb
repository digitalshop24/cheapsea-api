ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'

require File.expand_path('../../config/environment.rb', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'database_cleaner'
require 'vcr/config'

Rails.backtrace_cleaner.remove_silencers!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :active_record
    with.library :active_model

    with.library :rails
  end
end