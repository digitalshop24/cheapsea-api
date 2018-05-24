class API::AirportsController < ApiController
  swagger_controller :airports, 'Airports'

  swagger_api :autocomplete do
    summary 'Autocomplete airlines'
    param :query, :query, :string, :optional, 'Query search by name'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  def autocomplete
    render json: ::Filters::AirportsFilter.new(params).call.limit(20)
  end
end
