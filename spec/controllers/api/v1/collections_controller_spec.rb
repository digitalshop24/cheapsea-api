require 'rails_helper'

describe API::V1::CollectionsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:collection) { create(:collection, user: user) }

  describe "POST #create" do
    it "returns http success" do
      sign_in user
      post :create, params: { collection: FactoryGirl.attributes_for(:collection) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      sign_in user
      delete :destroy, params: { id: collection.id }
      expect(response).to have_http_status(:success)
    end
  end
end
