require 'rails_helper'

describe AirlinesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #autocomplete" do
    it "returns http success" do
      post :autocomplete, params: { query: 'New York' }
      expect(response).to have_http_status(:success)
    end
  end
end
