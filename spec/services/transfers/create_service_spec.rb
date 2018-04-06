require 'rails_helper'

describe Transfers::CreateService do
  subject { Transfers::CreateService.call(offer: @offer, params: params) }

  before do
    @user = create(:user)
    @offer = create(:offer)
  end

  let(:params) { FactoryGirl.attributes_for(:transfer) }

  use_vcr_cassette 'services/transfers/create_service'

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { Transfer.count }.by(1)
    end
  end
end
