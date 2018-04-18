class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit
  include CustomErrors

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  def current_user
    User.first if Rails.env.development?
  end
end
