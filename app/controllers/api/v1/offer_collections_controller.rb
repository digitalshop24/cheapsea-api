class API::V1::OfferCollectionsController < ApiController
  before_action :authenticate_user

  swagger_controller :offer_collections, 'Offer Collections management'

  swagger_api :destroy do |api|
    summary 'Destroy a relation'
    param :path, :id, :integer, :required, 'Offer Collection Id'
    ApiController.credentials(api)
    response :unauthorized
    response :unprocessable_entity
  end

  swagger_api :create do |api|
    summary 'Create a new collection'
    ApiController.credentials(api)
    api.param :form, 'offer_collection[offer_id]', :integer, :required, 'Offer id'
    api.param :form, 'offer_collection[collection_id]', :integer, :required, 'Collection id'
    response :unauthorized
    response :unprocess
  end

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
