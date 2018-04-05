class AirlinesController < ApiController
  swagger_controller :airlines, 'Airlines', resource_path: '/airlines'

  swagger_api :all do
    summary 'Fetch all airlines'
  end

  def all
    render json: Airlines::GetAllService.new.call, status: 200
  end
end
