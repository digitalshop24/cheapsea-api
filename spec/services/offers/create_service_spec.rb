require 'rails_helper'

describe Offers::CreateService do
  subject { Offers::CreateService.call(user: @user, params: params) }

  before do
    @user = create(:user)
  end

  let(:params) { FactoryGirl.attributes_for(:offer) }

  describe 'success' do
    use_vcr_cassette 'services/offers/create_service/success'

    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { Offer.count }.by(1)
    end
  end

  describe 'failure' do
    use_vcr_cassette 'services/offers/create_service/failure'

    let(:params) { {} }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has errors' do
      expect(subject.errors).not_to be nil
    end

    it 'checks that errors include particular error' do
      expect(subject.errors[:from_google_place_id]).to eq(['is missing'])
    end
  end
end
