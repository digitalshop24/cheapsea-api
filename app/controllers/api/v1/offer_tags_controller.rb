class API::V1::OfferTagsController < ApplicationController
  before_action :authenticate_user

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

  def create
    authorize OfferTag

    relation = OfferTag.new(tag_params)
    if relation.save
      render json: relation
    else
      render json: relation.errors.full_messages
    end
  end

  def destroy
    relation = find_offer_tag

    authorize relation

    relation.destroy
  end

  private

  def find_offer_tag
    OfferTag.find(params[:id])
  end

  def tag_params
    params.require(:offer_tag).permit(:offer_id, :tag_id)
  end
end
