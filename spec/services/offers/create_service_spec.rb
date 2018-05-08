require 'rails_helper'

describe Offers::CreateService do
  subject { Offers::CreateService.call(user: @user, params: params) }

  before do
    @user = create(:user)
    @city = create(:city)
  end

  let(:params) { FactoryGirl.attributes_for(:offer).merge(origin_id: @city.id, destination_id: @city.id) }

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { Offer.count }.by(1)
    end
  end

  describe 'failure' do
    let(:params) { {} }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has errors' do
      expect(subject.errors).not_to be nil
    end

    it 'checks that errors include particular error' do
      expect(subject.errors).to include('Origin must exist')
    end
  end
end
