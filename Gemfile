source 'https://rubygems.org'

ruby '2.5.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'
gem 'rack-attack', '5.0.1'
gem 'active_model_serializers', '0.10.2'
gem 'awesome_print', '1.7.0'
gem 'swagger-docs', '0.2.9'
gem "redis", '3.3.0'
gem 'mina', '1.0.2'
gem 'omniauth'
gem 'rails_admin', '~> 1.3'
gem 'figaro'
gem 'geocoder'
gem "interactor", "~> 3.0"
gem 'annotate'
gem 'dry-validation'
gem 'pundit'
gem 'httparty'
gem 'redis-namespace'
gem 'slackistrano'
gem 'carrierwave'                           # This gem provides a simple and extremely flexible way to upload files from Ruby applications. It works well with Rack based web applications, such as Ruby on Rails.
gem 'fog', '~> 1.36.0'                      # Module for the 'fog' gem to support Amazon Web Services http://aws.amazon.com/
gem 'mini_magick', require: false           # A ruby wrapper for ImageMagick or GraphicsMagick command line.
gem 'sidekiq'
gem 'sidekiq-statistic'
gem 'kaminari'
gem 'knock', path: 'vendor/knock'
gem 'russian'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Use RSpec for specs
  gem 'rspec-rails', '3.5.2'

  # Use Factory Girl for generating random test data
  gem 'factory_girl_rails', '4.7.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'webmock'
  gem 'database_cleaner'
  gem 'vcr', '~> 3.0.3'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
