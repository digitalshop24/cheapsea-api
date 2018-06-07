class API::V1::TagsController < ApiController
  before_action :authenticate_user, except: %i[index show]

  include V1::TagsControllerDoc

  def index
    render json: Tag.includes(:offers).page(params[:page])
  end

  def show
    render json: TagSerializer.new(find_tag).serializable_hash
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
