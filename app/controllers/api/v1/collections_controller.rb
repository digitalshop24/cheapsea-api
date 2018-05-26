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
    api.param :form, 'collection[offer_collections_attributes]', :string, :optional, '"offer_collections_attributes"=>{"0"=>{"offer_id"=>"5"}, "1"=>{"offer_id"=>"4"}}}'
    response :unauthorized
    response :unprocess
  end

  swagger_api :show do
    summary 'Show a collection'
    param :path, :id, :integer, :optional, 'Collection Id'
  end

  def index
    render json: Collection.includes(:offers).page(params[:page])
  end

  def show
    render json: CollectionSerializer.new(find_collection).serializable_hash
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

  def params_array
    [
      :name,
      :name_en,
      :desc,
      offer_collections_attributes: [:id, :offer_id, :_destroy]
    ]
  end

  def collection_params
    params.require(:collection).permit(params_array)
  end
end
