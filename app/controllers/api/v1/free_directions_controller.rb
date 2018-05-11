class API::V1::FreeDirectionsController < ApiController
  swagger_controller :free_directions, 'Free directions management'

  swagger_api :index do
    summary 'All free directions'
  end

  def index
    directions = FreeDirection.includes(:origin, :destination)
    render json: ::FreeDirectionSerializer.new(directions)
  end
end
