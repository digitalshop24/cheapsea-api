require 'rails_helper'

describe API::V1::OffersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #create" do
    it "returns http success" do
      sign_in user
      get :create, params: {"offer"=>{"name"=>"sdf", "from_google_place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g", "to_google_place_id"=>"ChIJOwg_06VPwokRYv534QaPC8g"}}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    let!(:offer) { create(:offer) }

    it "returns http success" do
      sign_in user
      patch :index, params: { id: offer.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    let!(:offer) { create(:offer) }

    it "returns http success" do
      sign_in user
      delete :index, params: { id: offer.id }
      expect(response).to have_http_status(:success)
    end
  end
end
