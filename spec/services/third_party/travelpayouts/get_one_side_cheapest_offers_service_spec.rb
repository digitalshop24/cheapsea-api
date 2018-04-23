require 'rails_helper'

describe ThirdParty::Travelpayouts::GetOneSideCheapestOffersService do
  subject do
    ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: 'LED', destination: destination)
  end

  let(:destination) { 'NYC' }

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_one_side_cheapest_offers_service/success'

    it 'checks that result successed' do
      expect(subject['success']).to eq(true)
    end
  end

  describe 'success' do
    use_vcr_cassette 'services/third_party/travelpayouts/get_one_side_cheapest_offers_service/failed'

    let(:destination) { 'NOTEXISTED' }

    it 'checks that service failed' do
      expect{subject}.to raise_error('ThirdParty::Travelpayouts::GetOneSideCheapestOffersService | Parameter destination length more than 3')
    end
  end
end
