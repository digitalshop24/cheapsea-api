require 'rails_helper'

describe API::AirlinesController, type: :controller do
  describe "POST #autocomplete" do
    it "returns http success" do
      post :autocomplete, params: { query: 'New York' }
      expect(response).to have_http_status(:success)
    end
  end
end
