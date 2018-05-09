require 'rails_helper'

describe API::V1::OfferTagsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:tag) { create(:tag, user: user) }
  let(:offer) { create(:offer, user: user) }
  let(:offer_tag) { create(:offer_tag, offer: offer, tag: tag) }

  describe "POST #create" do
    it "returns http success" do
      sign_in user
      post :create, params: { offer_tag: FactoryGirl.attributes_for(:offer_tag) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      sign_in user
      delete :destroy, params: { id: offer_tag.id }
      expect(response).to have_http_status(:success)
    end
  end
end
