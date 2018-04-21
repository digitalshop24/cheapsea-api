require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_USER'], ENV['SIDEKIQ_PASSWORD']]
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: 'cheapsea' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], namespace: 'cheapsea' }

  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::Server::Logging
    chain.add Sidekiq::Middleware::Server::RetryJobs
    chain.add Sidekiq::Statistic::Middleware
  end
end