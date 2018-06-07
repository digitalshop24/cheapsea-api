class API::V1::OfferTagsController < ApplicationController
  before_action :authenticate_user

  include ::V1::OfferTagsControllerDoc

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
