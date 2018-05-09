require 'rails_helper'

describe API::V1::TagsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:tag) { create(:tag, user: user) }

  describe "POST #create" do
    it "returns http success" do
      sign_in user
      post :create, params: { tag: FactoryGirl.attributes_for(:tag) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: tag.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      sign_in user
      delete :destroy, params: { id: tag.id }
      expect(response).to have_http_status(:success)
    end
  end
end
