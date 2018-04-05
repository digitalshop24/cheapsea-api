require 'rails_helper'

describe AirlinesController, type: :controller do
  use_vcr_cassette 'controllers/arlines/all'

  describe "GET #all" do
    it "returns http success" do
      get :all
      expect(response).to have_http_status(:success)
    end
  end
end
