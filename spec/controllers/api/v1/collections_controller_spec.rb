require 'rails_helper'

RSpec.describe API::V1::CollectionsController, type: :controller do
  let(:user) { create(:user, role: 'admin') }
  let(:collection) { create(:collection) }

  describe "GET #create" do
    it "returns http success" do
      sign_in user
      get :create, params: { collection: FactoryGirl.attributes_for(:collection) }
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
      get :show, params: { id: collection.id }
      expect(response).to have_http_status(:success)
    end
  end
end
