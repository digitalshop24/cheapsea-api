Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'profiles/show'
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount_devise_token_auth_for 'User', at: 'auth'

  mount Sidekiq::Web => '/sidekiq'

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  scope 'auth' do
    post '/' => 'auth#create'
    put '/' => 'auth#update'
    post '/sign_in' => 'auth#sign_in'
  end

  #scope 'geo', controller: :geo do
  #  post :autocomplete
  #end

  resources :airlines, only: :index do
    post :autocomplete, on: :collection
  end

  default_url_options host: ENV['HOST']

  namespace :api do
    namespace :v1 do
      resources :offers, only: %i[index show create update destroy]
      resource :profile, only: :show
    end
  end
end
