class ApplicationController < ActionController::Base
  include Knock::Authenticable
  include Pundit
  include CustomErrors

  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  before_action :cors_preflight_check

  def cors_preflight_check
    return unless request.method == :options
  end
end
