module AuthControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :auth, 'Auth'

    swagger_api :create do
      summary 'Sign in'
      notes 'Generate JWT token'
      param :form, 'auth[email]', :string, :required, 'Email'
      param :form, 'auth[password]', :string, :required, 'Password'
    end
  end
end
