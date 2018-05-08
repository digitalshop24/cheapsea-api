require 'rails_helper'

describe Transfers::CreateService do
  subject { Transfers::CreateService.call(offer: @offer, params: params, user: @user) }

  before do
    @user = create(:user)
    @offer = create(:offer)
    @city = create(:city)
  end

  let(:params) { { city_id: @city.id } }

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { Transfer.count }.by(1)
    end
  end
end
