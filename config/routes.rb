Rails.application.routes.draw do
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

  default_url_options host: ENV['HOST'] || 'localhost:3000'

  namespace :api do
    namespace :v1 do
      resources :offers, only: %i(index create)
    end
  end
end
