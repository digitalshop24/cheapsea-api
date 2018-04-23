require 'rails_helper'

describe ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService do
  subject do
    ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService.call(origin: 'LED', destination: destination)
  end

  let(:destination) { 'NYC' }

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_two_sides_cheapest_offers_service/success'

    it 'checks that result successed' do
      expect(subject.success?).to be true
    end
  end

  describe 'failed' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_two_sides_cheapest_offers_service/failed'

    let(:destination) { 'NOTEXISTED' }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has an error' do
      expect(subject.error).to eq('Resource not found. Check out API documentation at http://api.travelpayouts.com/')
    end
  end
end
