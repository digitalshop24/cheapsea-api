require 'rails_helper'

describe API::AirportsController, type: :controller do
  describe "GET #autocomplete" do
    it "returns http success" do
      post :autocomplete, params: { query: 'Phoenix' }
      expect(response).to have_http_status(:success)
    end
  end
end
