Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*',
             headers: %w[access-token uid client],
             methods: %i[get post put patch delete options head],
             expose: %w[access-token uid client]
  end
end
