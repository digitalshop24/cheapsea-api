require 'rails_helper'

describe Offers::CreateValidation do
  subject do
    Offers::CreateValidation.call(params)
  end

  let(:params) { FactoryGirl.attributes_for(:offer) }

  use_vcr_cassette 'validations/offers/create_validation'

  describe 'valid' do
    it 'checks that validation is successful' do
      expect(subject.success?).to be true
    end
  end

  describe 'invalid' do
    let(:params) { {} }

    it 'checks that validation is failure' do
      expect(subject.failure?).to be true
    end

    it 'checks that validation has errors' do
      expect(subject.errors).not_to be nil
    end


    context 'params' do
      context 'name' do
        it 'is missing' do
          expect(subject.errors[:name]).to eq(['is missing'])
        end
      end

      context 'from_google_place_id' do
        it 'is missing' do
          expect(subject.errors[:from_google_place_id]).to eq(['is missing'])
        end
      end

      context 'to_google_place_id' do
        it 'is missing' do
          expect(subject.errors[:to_google_place_id]).to eq(['is missing'])
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
