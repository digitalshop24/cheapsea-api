class API::V1::OffersController < ApiController
  before_action :authenticate_user!, except: %i(index show)

  swagger_controller :offers, 'Offer Management'

  def self.params(api)
    ApiController.credentials(api)
    api.param :form, 'offer[offer_type]', :string, :optional, 'Offer type: airplane, trane, bus, car_rent'
    api.param :form, 'offer[discount_type]', :string, :optional, 'Discount type: hot, seasonal, erroneous, other'
    api.param :form, 'offer[airline_id]', :string, :optional, 'Airline id'
    api.param :form, 'offer[transfers_count]', :integer, :optional, 'Transfers count'
    api.param :form, 'offer[date_from]', :string, :optional, 'Start date of offer'
    api.param :form, 'offer[date_to]', :string, :optional, 'End date of offer'
    api.param :form, 'offer[date_end]', :string, :optional, 'Date when offer will archived automaticly'
    api.param :form, 'offer[price]', :integer, :optional, 'Price'
    api.param :form, 'offer[currency_type]', :string, :optional, 'Currency type: RUB, USD, EUR'
    api.param :form, 'offer[discount_rate]', :integer, :optional, 'Discount rate'
    api.param :form, 'offer[description]', :string, :optional, 'Description'
  end

  swagger_api :create do |api|
    summary 'Create a new Offer item'
    API::V1::OffersController.params(api)
    api.param :form, 'offer[name]', :string, :required, 'Name'
    api.param :form, 'offer[is_direct]', :boolean, :required, 'Is a direct flight?'
    api.param :form, 'offer[from_google_place_id]', :string, :required, 'Departure place(ex: ChIJOwg_06VPwokRYv534QaPC8g for New York)'
    api.param :form, 'offer[to_google_place_id]', :string, :required, 'Arrival place(ex: ChIJGzE9DS1l44kRoOhiASS_fHg for Boston)'
    api.param :form, 'transfers_params', :string, :optional, 'Create transfers. ex: [{"google_place_id": "ChIJOwg_06VPwokRYv534QaPC8g", "airline_id": "1"}, {"google_place_id": "ChIJOwg_06VPwokRYv534QaPC8g", "airline_id": "1"}]'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  swagger_api :update do |api|
    summary 'Update an Offer item'
    param :path, :id, :integer, :optional, 'Offer Id'
    API::V1::OffersController.params(api)
    api.param :form, 'offer[name]', :string, :optional, 'Name'
    api.param :form, 'offer[is_direct]', :boolean, :optional, 'Is a direct flight?'
    api.param :form, 'offer[from_google_place_id]', :string, :optional, 'Departure place(ex: ChIJOwg_06VPwokRYv534QaPC8g for New York)'
    api.param :form, 'offer[to_google_place_id]', :string, :optional, 'Arrival place(ex: ChIJGzE9DS1l44kRoOhiASS_fHg for Boston)'
    api.param :form, 'offer[status]', :string, :optional, 'Status: draft, published'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  swagger_api :destroy do |api|
    summary 'Destroy an Offer item'
    param :path, :id, :integer, :optional, 'Offer Id'
    ApiController.credentials(api)
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :unprocessable_entity
  end

  swagger_api :index do
    summary 'All offers'
  end

  swagger_api :show do
    summary 'Show an offer'
    param :path, :id, :integer, :optional, 'Offer Id'
  end

  def index
    render json: ::Filters::OfferFilter.new(params.permit(params_array)).call, status: 200
  end

  def create
    authorize Offer

    service = Offers::CreateService.call(user: current_user, params: full_params, transfers_params: transfers_params)
    if service.success?
      render json: service.result, status: 200
    else
      render json: service.errors, status: 500
    end
  end

  def show
    render json: find_an_offer, status: 200
  end

  def update
    offer = find_an_offer
    authorize offer

    params = current_user.member? ? stripped_params : full_params

    validation = Offers::UpdateValidation.call(params)
    if validation.errors.present?
      render json: validation.errors, status: 500
      return
    end

    if offer.update(params)
      render json: offer, status: 200
    else
      render json: offer.errors.full_messages, status: 500
    end
  end

  def destroy
    offer = find_an_offer
    authorize offer
    offer.destroy
    render status: 200
  end

  private

  def find_an_offer
    Offer.find(params[:id])
  end

  def params_array
    %i(offer_type discount_type name from_google_place_id to_google_place_id airline_id is_direct transfers_count
      date_from date_to date_end price currency_type discount_rate description status transfers_params)
  end

  def full_params
    params.require(:offer).permit(params_array)
  end

  def stripped_params
    params.require(:offer).permit(params_array.tap { |arr| arr.delete(:status) })
  end

  def transfers_params
    params[:transfers_params]
  end
end
