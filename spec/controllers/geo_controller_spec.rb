require 'rails_helper'

describe GeoController, type: :controller do
  use_vcr_cassette 'controllers/geo/autocomplete'

  describe "GET #autocomplete" do
    it "returns http success" do
      post :autocomplete, params: { input: 'New York' }
      expect(response).to have_http_status(:success)
    end
  end
end
