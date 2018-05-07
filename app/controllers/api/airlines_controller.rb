class API::AirlinesController < ApiController
  swagger_controller :airlines, 'Airlines'

  swagger_api :autocomplete do
    summary 'Autocomplete airlines'
    param :query, :query, :string, :optional, 'Query search by name'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  def autocomplete
    render json: Airline.where('name ILIKE ?', "%#{params[:query]}%")
  end
end
