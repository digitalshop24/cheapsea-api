require 'rails_helper'

describe ThirdParty::Travelpayouts::GetAirportsService do
  subject do
    ThirdParty::Travelpayouts::GetAirportsService.new.call
  end

  use_vcr_cassette 'services/third_party/travelpayouts/get_airports_service'

  it 'checks that result is not empty' do
    expect(subject).not_to be_empty
  end
end
