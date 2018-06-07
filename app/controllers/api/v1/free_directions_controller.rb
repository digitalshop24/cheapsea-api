class API::V1::FreeDirectionsController < ApiController
  include ::V1::FreeDirectionsControllerDoc

  def index
    directions = FreeDirection.includes(:origin, :destination)
    render json: ::FreeDirectionSerializer.new(directions)
  end
end
