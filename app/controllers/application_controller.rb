class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit
  include CustomErrors

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  before_action :cors_preflight_check

  def current_user
    User.first if Rails.env.development?
  end

  def cors_preflight_check
    return unless request.method == :options
  end
end
