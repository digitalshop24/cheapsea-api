class API::AuthController < ApiController
  include AuthControllerDoc

  def create
    render json: { token: ::Knock::AuthTokenController.new.create(params) }
  end
end
