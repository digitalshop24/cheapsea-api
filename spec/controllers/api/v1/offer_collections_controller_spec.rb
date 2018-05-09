require 'rails_helper'

describe API::V1::OfferCollectionsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:collection) { create(:collection, user: user) }
  let(:offer) { create(:offer, user: user) }
  let(:offer_collection) { create(:offer_collection, offer: offer, collection: collection) }

  describe "POST #create" do
    it "returns http success" do
      sign_in user
      post :create, params: { offer_collection: FactoryGirl.attributes_for(:offer_collection) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      sign_in user
      delete :destroy, params: { id: offer_collection.id }
      expect(response).to have_http_status(:success)
    end
  end
end
