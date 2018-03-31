Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  mount_devise_token_auth_for 'User', at: 'auth'

  get '/docs' => redirect('/api_html/dist/index.html?url=/apidocs/api-docs.json')

  post 'auth' => 'auth#create'
  put 'auth' => 'auth#update'
  post 'auth/sign_in' => 'auth#sign_in'

  default_url_options host: ENV['HOST'] || 'localhost:3000'

  namespace :api do
    namespace :v1 do

    end
  end
end
