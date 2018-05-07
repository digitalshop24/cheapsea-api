class API::V1::CollectionsController < ApiController
  before_action :authenticate_user, except: %i[index show]

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
    response :unauthorized
    response :unprocess
  end

  swagger_api :show do
    summary 'Show a collection'
    param :path, :id, :integer, :optional, 'Collection Id'
  end

  def index
    render json: Collection.all.page(params[:page])
  end

  def show
    render json: find_collection
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
    Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :name_en, :desc)
  end
end
