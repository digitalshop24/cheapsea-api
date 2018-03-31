class AuthController < ApiController
  swagger_controller :auth, "User Management", resource_path: "/auth"

  def self.credentials(api)
    api.param :header, "uid", :string, :required, "uid"
    api.param :header, "access-token", :string, :required, "access-token"
    api.param :header, "client", :string, :required, "client"
  end

  swagger_api :create do |api|
    summary "Create a new User item"
    notes "Notes for creating a new User item"
    api.param :form, 'email', :string, :required, "Email"
    api.param :form, 'password', :string, :required, "Password"
    api.param :form, 'password_confirmation', :string, :required, "Password confirmation"
    api.param :form, 'confirm_success_url', :string, :required, "Confirm_success_url"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :unprocessable_entity
  end

  swagger_api :update do |api|
    summary "Update a existed User item"
    notes "Notes for updating a existed User item"
    AuthController::credentials(api)
    api.param :form, :password, :string, :optional, "Password"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :unprocessable_entity
  end

  swagger_api :sign_in do |api|
    summary "Sign in"
    notes "Getting token"
    api.param :form, :email, :string, :required, "Email"
    api.param :form, :password, :string, :required, "Password"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :unprocessable_entity
  end
end
