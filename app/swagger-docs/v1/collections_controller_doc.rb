module V1::CollectionsControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :collections, 'Collections management'

    swagger_api :index do
      summary 'All collections'
      param :query, :page, :integer, :optional, 'Page'
    end

    swagger_api :destroy do |api|
      summary 'Destroy a collection'
      param :path, :id, :integer, :required, 'Collection Id'
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :create do |api|
      summary 'Create a new collection'
      ApiController.credentials(api)
      api.param :form, 'collection[name]', :string, :required, 'Name'
      api.param :form, 'collection[name_en]', :string, :optional, 'English name'
      api.param :form, 'collection[desc]', :string, :optional, 'Description'
      api.param :form, 'collection[offer_collections_attributes]', :string, :optional, '"offer_collections_attributes"=>{"0"=>{"offer_id"=>"5"}, "1"=>{"offer_id"=>"4"}}}'
      response :unauthorized
      response :unprocess
    end

    swagger_api :show do |api|
      summary 'Show a collection'
      param :path, :id, :integer, :optional, 'Collection Id'
      API::V1::OffersController.filter_params(api, 'offers')
    end
  end
end
