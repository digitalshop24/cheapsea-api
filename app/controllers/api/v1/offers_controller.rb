class API::V1::OffersController < ApiController
  swagger_controller :offers, 'Offer Management', resource_path: '/api/v1/offers'

  swagger_api :create do |api|
    summary 'Create a new Offer item'
    notes 'Notes for creating a new Offer item'
    ApiController::credentials(api)
    api.param :form, 'offer[offer_type]', :string, :optional, 'Offer type: airplane, trane, bus, car_rent'
    api.param :form, 'offer[discount_type]', :string, :optional, 'Discount type: hot, seasonal, erroneous, other'
    api.param :form, 'offer[name]', :string, :required, 'Name'
    api.param :form, 'offer[from_google_place_id]', :string, :required, 'Departure place(ex: ChIJOwg_06VPwokRYv534QaPC8g for New York)'
    api.param :form, 'offer[to_google_place_id]', :string, :required, 'Arrival place(ex: ChIJGzE9DS1l44kRoOhiASS_fHg for Boston)'
    api.param :form, 'offer[airline_id]', :string, :optional, 'Airline id'
    api.param :form, 'offer[flight_type]', :string, :optional, 'Flight type: direct, transfer'
    api.param :form, 'offer[transfers_count]', :integer, :optional, 'Transfers count'
    api.param :form, 'offer[date_from]', :string, :optional, 'Start date of offer'
    api.param :form, 'offer[date_to]', :string, :optional, 'End date of offer'
    api.param :form, 'offer[date_end]', :string, :optional, 'Date when offer will archived automaticly'
    api.param :form, 'offer[price]', :integer, :optional, 'Price'
    api.param :form, 'offer[currency_type]', :string, :optional, 'Currency type: RUB, USD, EUR'
    api.param :form, 'offer[discount_rate]', :integer, :optional, 'Discount rate'
    api.param :form, 'offer[description]', :string, :optional, 'Description'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  swagger_api :index do
    summary 'All offers'
  end

  def create
    authenticate_user!

    service = Offers::CreateService.call(user: User.first, params: offer_params)
    if service.success?
      render json: service.result, status: 200
    else
      render json: service.errors, status: 500
    end
  end

  def index
    render json: Offer.all
  end

  private

  def offer_params
    params.require(:offer).permit(
      :offer_type, :discount_type, :name, :from_google_place_id, :to_google_place_id, :airline_id, :flight_type, :transfers_count,
      :date_from, :date_to, :date_end, :price, :currency_type, :discount_rate, :description
    )
  end
end
