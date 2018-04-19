require 'rails_helper'

describe ThirdParty::Geo::PlaceInfoService do
  subject { ThirdParty::Geo::PlaceInfoService.call(place_id: place_id) }

  let(:place_id) { 'ChIJOwg_06VPwokRYv534QaPC8g' }

  use_vcr_cassette 'services/geo/place_info'

  describe 'success' do
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
end
