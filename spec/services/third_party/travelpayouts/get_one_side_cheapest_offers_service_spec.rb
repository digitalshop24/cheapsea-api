require 'rails_helper'

describe ThirdParty::Travelpayouts::GetOneSideCheapestOffersService do
  subject do
    ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: 'LED', destination: destination, month: month)
  end

  let(:month) { nil }

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_one_side_cheapest_offers_service/success'

    let(:destination) { 'NYC' }
    let(:month) { Date.current }

    it 'checks that result successed' do
      expect(subject.success?).to be true
    end
  end

  describe 'failed' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_one_side_cheapest_offers_service/failed'

    let(:destination) { 'GFJ' }

    it 'checks that service failed' do
      expect(subject.failure?).to be true
    end

    it 'checks that service has an error' do
      expect(subject.error).to eq('Parameter month is not Date')
    end
  end
end
