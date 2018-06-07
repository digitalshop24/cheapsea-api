class API::V1::OffersController < ApiController
  before_action :authenticate_user, except: %i[index show]

  include ::V1::OffersControllerDoc

  def index
    authorize Offer

    offers = ::OffersFilterQuery.new(params, page: params[:page] || 1, order: params[:order]).call

    render json: OfferSerializer.new(offers, {
      meta: {
        count: offers.page.total_count,
        pages: offers.page.total_pages
      }
    }).serializable_hash, status: 200
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
      :faq,
      transfers_attributes: [:id, :airline_id, :user_id, :airport_id, :city_id, :to_airline_id, :to_city_id, :to_airport_id, :number, :_destroy, :_create, :_update],
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
