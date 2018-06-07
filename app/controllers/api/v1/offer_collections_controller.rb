class API::V1::OfferCollectionsController < ApiController
  before_action :authenticate_user

  include ::V1::OfferCollectionsControllerDoc

  def create
    authorize OfferCollection

    relation = OfferCollection.new(collection_params)
    if relation.save
      render json: relation
    else
      render json: relation.errors.full_messages
    end
  end

  def destroy
    relation = find_offer_collection

    authorize relation

    relation.destroy
  end

  private

  def find_offer_collection
    OfferCollection.find(params[:id])
  end

  def collection_params
    params.require(:offer_collection).permit(:offer_id, :collection_id)
  end
end
