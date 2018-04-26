require 'rails_helper'

describe ThirdParty::Geo::PlaceInfoService do
  subject { ThirdParty::Geo::PlaceInfoService.call(place_id: place_id) }

  let(:place_id) { 'ChIJOwg_06VPwokRYv534QaPC8g' }

  describe 'success' do
    use_vcr_cassette 'services/third_party/geo/place_info/success'

    it 'checks that service is successful' do
      expect(subject.success?).to be true
    end

    it 'checks that errors is nil' do
      expect(subject.error).to be_nil
    end

    it 'checks that result is not nil' do
      expect(subject.result).not_to be_nil
    end

    it 'checks that result contains an info about the city' do
      expect(subject.result['address_components'].first['long_name']).to eq('New York')
    end
  end

  describe 'failed' do
    use_vcr_cassette 'services/third_party/geo/place_info/failed'

    let(:place_id) { 'wrong_id' }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that errors is nil' do
      expect(subject.error).to eq('Invalid request. Invalid \'place_id\' parameter.')
    end
  end
end
