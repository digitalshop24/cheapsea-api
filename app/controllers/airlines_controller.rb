class AirlinesController < ApiController
  swagger_controller :airlines, 'Airlines'

  swagger_api :index do
    summary 'Fetch all airlines'
  end

  swagger_api :autocomplete do |api|
    summary 'Autocomplete airlines'
    api.param :form, 'query', :string, :optional, 'Query search'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  def index
    render json: Airline.all, status: 200
  end

  def autocomplete
    # render json: Airline.where('name LIKE ?', "%#{params[:query]}%")
    render json: Airline.where('name ILIKE ?', "%#{params[:query]}%")
  end
end
