require 'rails_helper'

describe API::CitiesController, type: :controller do
  describe "GET #autocomplete" do
    before { create(:city, name: 'New York') }

    it "returns http success" do
      post :autocomplete, params: { query: 'New York' }
      expect(response).to have_http_status(:success)
    end
  end
end
