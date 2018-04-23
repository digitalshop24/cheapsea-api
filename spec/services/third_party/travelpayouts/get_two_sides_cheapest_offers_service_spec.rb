require 'rails_helper'

describe ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService do
  subject do
    ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService.call(origin: 'LED', destination: destination)
  end

  let(:destination) { 'NYC' }

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_two_sides_cheapest_offers_service/success'

    it 'checks that result successed' do
      expect(subject['success']).to eq(true)
    end
  end

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_two_sides_cheapest_offers_service/failed'

    let(:destination) { 'NOTEXISTED' }

    it 'checks that service failed' do
      expect{subject}.to raise_error('ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService | Resource not found. Check out API documentation at http://api.travelpayouts.com/')
    end
  end
end
