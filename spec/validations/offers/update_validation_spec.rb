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

  describe 'invalid' do
    context 'params' do
      context 'from_google_place_id' do
        let(:params) { { from_google_place_id: 'wrong_id' } }
        it 'doesnt exist' do
          expect(subject.errors[:from_google_place_id]).to eq(['Google place does not exist'])
        end
      end

      context 'to_google_place_id' do
        let(:params) { { to_google_place_id: 'wrong_id' } }
        it 'doesnt exist' do
          expect(subject.errors[:to_google_place_id]).to eq(['Google place does not exist'])
        end
      end

      context 'airline_id' do
        let(:params) { { airline_id: 0 } }

        it 'does not exist' do
          expect(subject.errors[:airline_id]).to eq(['Airline does not exist'])
        end
      end
    end
  end
end
