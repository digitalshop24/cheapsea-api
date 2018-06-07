class API::V1::CollectionsController < ApiController
  before_action :authenticate_user, except: %i[index show]

  include ::V1::CollectionsControllerDoc

  def index
    render json: Collection.includes(:offers).page(params[:page])
  end

  def show
    render json: CollectionSerializer.new(find_collection, {
      meta: {
        first_date: collection_offers.first&.date_from,
        last_date: collection_offers.last&.date_to,
        offers: serialize_offers(params)
      }
    }).serializable_hash
  end

  def create
    authorize Collection

    collection = current_user.collections.new(collection_params)
    if collection.save
      render json: collection
    else
      render json: collection.errors.full_messages
    end
  end

  def destroy
    collection = find_collection

    authorize collection

    collection.destroy
  end

  private

  def find_collection
    @collection ||= Collection.find(params[:id])
  end

  def collection_offers
    @offers ||= find_collection.offers.order(date_from: :asc)
  end

  def params_array
    [
      :name,
      :name_en,
      :desc,
      :short_desc,
      :image,
      offer_collections_attributes: [:id, :offer_id, :_destroy]
    ]
  end

  def collection_params
    params.require(:collection).permit(params_array)
  end

  def serialize_offers(params)
    params[:offers] ||= {}

    OfferSerializer.new(
      OffersFilterQuery.new(
        params[:offers].merge(collection_id: params[:id]),
        page: params[:offers][:page] || 1,
        order: params[:offers][:order]
      ).call
    ).serializable_hash
  end
end
