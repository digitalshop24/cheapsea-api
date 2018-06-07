module V1::OfferTagsControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :offer_tags, 'Offer Tags management'

    swagger_api :destroy do |api|
      summary 'Destroy a relation'
      param :path, :id, :integer, :required, 'Offer Tag Id'
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :create do |api|
      summary 'Create a new tag'
      ApiController.credentials(api)
      api.param :form, 'offer_tag[offer_id]', :integer, :required, 'Offer id'
      api.param :form, 'offer_tag[tag_id]', :integer, :required, 'Tag id'
      response :unauthorized
      response :unprocess
    end
  end
end
