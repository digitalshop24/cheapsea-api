require 'rails_helper'

describe Offers::UpdateService do
  subject { Offers::UpdateService.call(user: @user, offer: @offer, params: params, transfers_params: transfers_params) }

  before do
    @user = create(:user)
    @offer = create(:offer, user: @user, name: 'one')
    @city = create(:city)
    @transfer = create(:transfer, offer: @offer, user: @user, city_id: @city.id, airline_id: nil)
    @airline = create(:airline)
  end

  let(:params) { FactoryGirl.attributes_for(:offer, name: 'two') }
  let(:transfers_params) { {} }

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { @offer.name }.from('one').to('two')
    end

    context 'transfers' do
      let(:transfers_params) do
        "[{\"id\": \"#{@transfer.id}\", \"city_id\": \"#{@city.id}\", \"airline_id\": \"#{@airline.id}\"}]"
      end

      it 'checks that service is successful' do
        expect(subject.success?).to be true
      end
    end
  end
end
