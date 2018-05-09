require 'rails_helper'

describe Offers::UpdateService do
  subject { Offers::UpdateService.call(user: @user, offer: @offer, params: params) }

  before do
    @user = create(:user)
    @offer = create(:offer, user: @user, name: 'one')
    @city = create(:city)
    @airline = create(:airline)
  end

  let(:params) { FactoryGirl.attributes_for(:offer, name: 'two') }

  describe 'success' do
    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that record created in the db' do
      expect{ subject }.to change { @offer.name }.from('one').to('two')
    end
  end
end
