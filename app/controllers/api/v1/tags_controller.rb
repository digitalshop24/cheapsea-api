class API::V1::TagsController < ApiController
  before_action :authenticate_user, except: %i[index show]

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

  def index
    render json: Tag.includes(:offers).page(params[:page])
  end

  def show
    render json: find_tag
  end

  def create
    authorize Tag

    tag = current_user.tags.new(tag_params)
    if tag.save
      render json: tag
    else
      render json: tag.errors.full_messages
    end
  end

  def destroy
    tag = find_tag

    authorize tag

    tag.destroy
  end

  private

  def find_tag
    Tag.find(params[:id])
  end

  def params_array
    [:name]
  end

  def tag_params
    params.require(:tag).permit(params_array)
  end
end
