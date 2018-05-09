Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

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
      resources :tags, only: %i[index show create destroy]
      resources :offer_tags, only: %i[create destroy]
      resource :profile, only: %i[create show]
    end
  end
end
