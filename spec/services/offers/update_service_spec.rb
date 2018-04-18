require 'rails_helper'

describe Offers::UpdateService do
  subject { Offers::UpdateService.call(user: @user, offer: @offer, params: params, transfers_params: transfers_params) }

  before do
    @user = create(:user)
    @offer = create(:offer, user: @user, name: 'one')
    @transfer = create(:transfer, offer: @offer, user: @user, google_place_id: 'ChIJOwg_06VPwokRYv534QaPC8g', airline_id: nil)
    @airline = create(:airline)
  end

  let(:params) { FactoryGirl.attributes_for(:offer, name: 'two') }
  let(:transfers_params) { {} }

  use_vcr_cassette 'services/offers/update_service'

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { @offer.name }.from('one').to('two')
    end

    context 'transfers' do
      let(:transfers_params) do
        "[{\"id\": \"#{@transfer.id}\", \"google_place_id\": \"ChIJGzE9DS1l44kRoOhiASS_fHg\", \"airline_id\": \"#{@airline.id}\"}]"
      end

      it 'checks that service is successful' do
        expect(subject.success?).to be true
      end
    end
  end

  describe 'failure' do
    let(:params) { { from_google_place_id: 'wrong_id' } }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has errors' do
      expect(subject.errors).not_to be nil
    end

    it 'checks that errors include particular error' do
      expect(subject.errors[:from_google_place_id]).to eq(['Google place does not exist'])
    end

    context 'transfers' do
      let(:params) { FactoryGirl.attributes_for(:offer) }
      let(:transfers_params) do
        "[{\"id\": \"#{@transfer.id}\", \"google_place_id\": \"wrong_id\", \"airline_id\": \"#{@airline.id + 1}\"}]"
      end

      it 'checks that service is failed' do
        expect(subject.failure?).to be true
      end

      it 'checks that errors include particular error' do
        expect(subject.errors[:transfer][:google_place_id]).to eq(['Google place does not exist'])
      end

      it 'checks that errors include particular error' do
        expect(subject.errors[:transfer][:airline_id]).to eq(['Airline does not exist'])
      end
    end
  end
end
