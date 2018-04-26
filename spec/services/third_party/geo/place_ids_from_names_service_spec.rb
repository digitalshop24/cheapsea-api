require 'rails_helper'

describe ThirdParty::Geo::PlaceIdsFromNamesService do
  subject do
    ThirdParty::Geo::PlaceIdsFromNamesService.call(origin_name: origin_name, destination_name: destination_name)
  end

  describe 'success' do
    use_vcr_cassette 'services/third_party/geo/place_ids_from_names_service/success'

    let(:origin_name) { 'Нью-Йорк' }
    let(:destination_name) { 'Бостон' }

    it 'checks that service successed' do
      expect(subject.success?).to be true
    end

    it 'checks that result hash is not nil' do
      expect(subject.result).not_to be_nil
    end

    context 'origin' do
      it 'checks that origin has particular name' do
        expect(subject.result[:from_google_place_id]).to eq('ChIJOwg_06VPwokRYv534QaPC8g')
      end
    end

    context 'destination' do
      it 'checks that origin has particular name' do
        expect(subject.result[:to_google_place_id]).to eq('ChIJGzE9DS1l44kRoOhiASS_fHg')
      end
    end
  end

  describe 'failure' do
    use_vcr_cassette 'services/third_party/geo/place_ids_from_names_service/failure'

    let(:origin_name) { 'wrong origin' }
    let(:destination_name) { 'wrong destination' }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has an error' do
      expect(subject.error).to eq('from_google_place_is is nil')
    end

    context 'missing arguments' do
      context 'origin' do
        let(:origin_name) { nil }

        it 'checks that service has an error' do
          expect(subject.error).to eq('There should be 2 values')
        end
      end

      context 'destination' do
        let(:destination_name) { nil }

        it 'checks that service has an error' do
          expect(subject.error).to eq('There should be 2 values')
        end
      end
    end
  end
end
