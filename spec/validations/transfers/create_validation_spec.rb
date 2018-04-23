require 'rails_helper'

describe Transfers::CreateValidation do
  subject do
    Transfers::CreateValidation.call(params)
  end

  let(:params) { FactoryGirl.attributes_for(:transfer) }

  describe 'valid' do
    use_vcr_cassette 'validations/transfers/create_validation/valid'

    it 'checks that validation is successful' do
      expect(subject.success?).to be true
    end
  end

  describe 'invalid' do
    use_vcr_cassette 'validations/transfers/create_validation/invalid'

    context 'params' do
      context 'google_place_id' do
        let(:params) { { google_place_id: 'wrong_id' } }

        it 'doesnt exist' do
          expect(subject.errors[:google_place_id]).to eq(['Google place does not exist'])
        end
      end

      context 'airline_id' do
        let(:params) { { airline_id: 0 } }

        it 'doesnt exist' do
          expect(subject.errors[:airline_id]).to eq(['Airline does not exist'])
        end
      end
    end
  end
end
