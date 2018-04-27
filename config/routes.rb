Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount Sidekiq::Web => '/sidekiq'

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  default_url_options host: ENV['HOST']

  namespace :api do
    resource :auth, only: :create, controller: 'auth'
    resources :airlines, only: :index do
      post :autocomplete, on: :collection
    end

    namespace :v1 do
      resources :offers, only: %i[index show create update destroy]
      resource :profile, only: %i[create show]
    end
  end
end
