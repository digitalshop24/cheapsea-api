module V1::ProfilesControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :profiles, 'Profile Management'

    swagger_api :create do |api|
      summary 'Create profile'
      api.param :form, 'profile[email]', :string, :required, 'Email'
      api.param :form, 'profile[password]', :string, :required, 'Password'
      api.param :form, 'profile[password_confirmation]', :string, :required, 'Password confirmation'
      api.param :form, 'profile[name]', :string, :required, 'Name'
      api.param :form, 'profile[phone]', :string, :optional, 'Phone'
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :show do |api|
      summary 'Show profile'
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :geo do |api|
      summary 'Geo of profile'
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end
  end
end
