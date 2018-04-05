Rails.application.routes.draw do
  get 'airlines/all'

  namespace :api do
    namespace :v1 do
      get 'airlines/index'
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount_devise_token_auth_for 'User', at: 'auth'

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  scope 'auth' do
    post '/' => 'auth#create'
    put '/' => 'auth#update'
    post '/sign_in' => 'auth#sign_in'
  end

  scope 'geo', controller: :geo do
    post :autocomplete
  end

  scope 'airlines', controller: :airlines do
    get :all
  end

  default_url_options host: ENV['HOST']

  namespace :api do
    namespace :v1 do
      resources :offers, only: %i(index create update destroy)
    end
  end
end
