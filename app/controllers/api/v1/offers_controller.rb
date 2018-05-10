class API::V1::OffersController < ApiController
  before_action :authenticate_user, except: %i[index show]

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
    api.param :form, 'offer[discount_rate]', :integer, :optional, 'Discount rate'
    api.param :form, 'offer[description]', :string, :optional, 'Description'
    api.param :form, 'offer[two_sides]', :string, :optional, 'Two sides?'
    api.param :form, 'offer[from_airport_id]', :integer, :optional, 'ID of airport'
    api.param :form, 'offer[to_airport_id]', :integer, :optional, 'ID of airport'
    api.param :form, 'offer[quality]', :integer, :optional, 'Quality: unknown(default), bad, normal, good'
  end

  swagger_api :create do |api|
    summary 'Create a new Offer item'
    API::V1::OffersController.params(api)
    api.param :form, 'offer[name]', :string, :required, 'Name'
    api.param :form, 'offer[is_direct]', :boolean, :required, 'Is a direct flight?'
    api.param :form, 'offer[origin_id]', :integer, :required, 'Origin City id'
    api.param :form, 'offer[destination_id]', :integer, :required, 'Destination City id'
    api.param :form, 'offer[price]', :integer, :required, 'Price'
    api.param :form, 'offer[price_currency]', :integer, :required, 'Currency type: RUB, USD, EUR'
    api.param :form, 'offer[transfers_attributes]', :string, :optional, 'Create transfers. ex: "transfers_attributes"=>{"0"=>{"city_id"=>"1", "airline_id"=>"1"}, "1"=>{"city_id"=>"2"}}}'
    response :unauthorized
    response :unprocessable_entity
  end

  swagger_api :update do |api|
    summary 'Update an Offer item'
    param :path, :id, :integer, :required, 'Offer Id'
    API::V1::OffersController.params(api)
    api.param :form, 'offer[name]', :string, :optional, 'Name'
    api.param :form, 'offer[is_direct]', :boolean, :optional, 'Is a direct flight?'
    api.param :form, 'offer[price]', :integer, :optional, 'Price'
    api.param :form, 'offer[price_currency]', :integer, :optional, 'Currency type: RUB, USD, EUR'
    api.param :form, 'offer[origin_id]', :integer, :optional, 'Origin City id'
    api.param :form, 'offer[destination_id]', :integer, :optional, 'Destination City id'
    api.param :form, 'offer[status]', :string, :optional, 'Status: draft, published'
    api.param :form, 'offer[transfers_attributes]', :string, :optional, 'Update transfers. ex: "transfers_attributes"=>{"0"=>{"id"=>"1", "city_id"=>"1", "airline_id"=>"1"}, "1"=>{"id"=>"2", "city_id"=>"2"}}}'
    response :unauthorized
    response :unprocessable_entity
  end

  swagger_api :destroy do |api|
    summary 'Destroy an Offer item'
    param :path, :id, :integer, :required, 'Offer Id'
    ApiController.credentials(api)
    response :unauthorized
    response :unprocessable_entity
  end

  swagger_api :index do
    summary 'All offers'
    param :query, :page, :integer, :optional, 'Page'
    param :query, :name, :string, :optional, 'Name. (\'name ILIKE ? or name_auto ILIKE ?\')'
    param :query, :offer_type, :string, :optional, 'Offer type: airplane, trane, bus, car_rent'
    param :query, :discount_type, :string, :optional, 'Discount type: hot, seasonal, erroneous, other'
    param :query, :airline_id, :string, :optional, 'Airline id'
    param :query, :transfers_count, :integer, :optional, 'Transfers count'
    param :query, :date_from, :string, :optional, 'Start date of offer'
    param :query, :date_to, :string, :optional, 'End date of offer'
    param :query, :date_end, :string, :optional, 'Date when offer will archived automaticly'
    param :query, :price, :integer, :optional, 'Price'
    param :query, :price_currency, :integer, :optional, 'Currency type: RUB, USD, EUR'
    param :query, :discount_rate, :integer, :optional, 'Discount rate'
    param :query, :two_sides, :string, :optional, 'Two sides'
    param :query, :origin_id, :integer, :optional, 'Origin city id'
    param :query, :destination_id, :integer, :optional, 'Destination city id'
  end

  swagger_api :show do
    summary 'Show an offer'
    param :path, :id, :integer, :optional, 'Offer Id'
  end

  def index
    authorize Offer

    render json: ::Filters::OffersFilter.new(params, params[:page]).call, include: '**', status: 200
  end

  def create
    authorize Offer

    service = Offers::CreateService.call(user: current_user, params: full_params)
    if service.success?
      render json: service.result, status: 200
    else
      render json: service.errors, status: 500
    end
  end

  def show
    find_an_offer.increment!(:visits_count)
    render json: find_an_offer, status: 200
  end

  def update
    offer = find_an_offer
    authorize offer

    params = current_user.member? ? stripped_params : full_params

    service = Offers::UpdateService.call(user: current_user, offer: offer, params: params)
    if service.success?
      render json: service.offer, status: 200
    else
      render json: service.errors, status: 500
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
    [
      :offer_type,
      :discount_type,
      :name,
      :airline_id,
      :is_direct,
      :date_from,
      :date_to,
      :date_end,
      :price,
      :discount_rate,
      :description,
      :status,
      :price_currency,
      :two_sides,
      :from_airport_id,
      :to_airport_id,
      :origin_id,
      :quality,
      :destination_id,
      transfers_attributes: [:id, :airline_id, :user_id, :city_id, :_destroy, :_create, :_update],
      offer_tags_attributes: [:id, :tag_id, :user_id, :city_id, :_destroy, :_create, :_update]
    ]
  end

  def full_params
    params.require(:offer).permit(params_array)
  end

  def stripped_params
    params.require(:offer).permit(ConvertService.remove_params_from_array(params_array, %i[status]))
  end
end
