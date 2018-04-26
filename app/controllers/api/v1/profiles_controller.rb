class API::V1::ProfilesController < ApiController
  before_action :authenticate_user!

  swagger_controller :offers, 'Profile Management'

  def show
    render json: current_user
  end

  swagger_api :show do |api|
    summary 'Show profile'
    ApiController.credentials(api)
    response :unauthorized
    response :unprocessable_entity
  end
end
