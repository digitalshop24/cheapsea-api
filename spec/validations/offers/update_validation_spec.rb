require 'rails_helper'

describe Offers::UpdateValidation do
  subject do
    Offers::UpdateValidation.call(params)
  end

  let(:params) { FactoryGirl.attributes_for(:offer) }

  use_vcr_cassette 'validations/offers/update_validation'

  describe 'valid' do
    it 'checks that validation is successful' do
      expect(subject.success?).to be true
    end
  end
end
