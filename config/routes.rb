Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount Sidekiq::Web => '/sidekiq'

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  default_url_options host: ENV['HOST']

  namespace :api do
    resource :auth, only: :create, controller: 'auth'
    resources :airlines, only: [] do
      post :autocomplete, on: :collection
    end
    resources :cities, only: [] do
      post :autocomplete, on: :collection
    end
    resources :airports, only: [] do
      post :autocomplete, on: :collection
    end

    namespace :v1 do
      resources :offers, only: %i[index show create update destroy]
      resources :collections, only: %i[index show create destroy]
      resources :offer_collections, only: %i[create destroy]
      resource :profile, only: %i[create show]
    end
  end
end
