require 'rails_helper'

describe API::V1::ProfilesController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #show" do
    it "returns http success" do
      sign_in user
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
