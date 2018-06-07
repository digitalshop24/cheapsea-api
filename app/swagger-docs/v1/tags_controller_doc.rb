module V1::TagsControllerDoc
  extend ActiveSupport::Concern

  included do
    swagger_controller :tags, 'Tags management'

    swagger_api :index do
      summary 'All tags'
      param :query, :page, :integer, :optional, 'Page'
    end

    swagger_api :destroy do |api|
      summary 'Destroy a tag'
      param :path, :id, :integer, :required, 'Tag Id'
      ApiController.credentials(api)
      response :unauthorized
      response :unprocessable_entity
    end

    swagger_api :create do |api|
      summary 'Create a new tag'
      ApiController.credentials(api)
      api.param :form, 'tag[name]', :string, :required, 'Name'
      response :unauthorized
      response :unprocess
    end

    swagger_api :show do
      summary 'Show a tag'
      param :path, :id, :integer, :optional, 'Tag Id'
    end
  end
end
