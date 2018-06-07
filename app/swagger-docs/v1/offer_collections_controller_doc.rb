module V1::OfferCollectionsControllerDoc
  extend ActiveSupport::Concern

  included do
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
  end
end
