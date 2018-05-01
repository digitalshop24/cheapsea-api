require 'rails_helper'

describe ThirdParty::Geo::CitiesFromPlaceIdsService do
  subject do
    ThirdParty::Geo::CitiesFromPlaceIdsService.call(
      from_google_place_id: from_google_place_id,
      to_google_place_id: to_google_place_id
    )
  end

  describe 'success' do
    use_vcr_cassette 'services/third_party/geo/cities_from_place_ids_service/success'

    let(:from_google_place_id) { 'ChIJOwg_06VPwokRYv534QaPC8g' }
    let(:to_google_place_id) { 'ChIJGzE9DS1l44kRoOhiASS_fHg' }

    it 'checks that service successed' do
      expect(subject.success?).to be true
    end

    it 'checks that result hash is not nil' do
      expect(subject.result).not_to be_nil
    end

    context 'origin' do
      let!(:city) { create(:city, name: 'Нью-Йорк') }

      it 'checks that origin has particular name' do
        expect(subject.result[:origin]).to eq(city)
      end
    end

    context 'destination' do
      let!(:city) { create(:city, name: 'Бостон') }

      it 'checks that origin has particular name' do
        expect(subject.result[:destination]).to eq(city)
      end
    end
  end

  describe 'failure' do
    use_vcr_cassette 'services/third_party/geo/cities_from_place_ids_service/failure'

    let(:from_google_place_id) { 'wrong_id' }
    let(:to_google_place_id) { 'wrong_id' }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has an error' do
      expect(subject.error).to eq('Invalid request. Invalid \'place_id\' parameter.')
    end

    context 'missing arguments' do
      context 'origin' do
        let(:origin) { nil }

        it 'checks that service has an error' do
          expect(subject.error).to eq('Invalid request. Invalid \'place_id\' parameter.')
        end
      end

      context 'destination' do
        let(:destination) { nil }

        it 'checks that service has an error' do
          expect(subject.error).to eq('Invalid request. Invalid \'place_id\' parameter.')
        end
      end
    end
  end
end