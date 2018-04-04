class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit
  include CustomErrors

  rescue_from Pundit::NotAuthorizedError, with: :forbidden
end
