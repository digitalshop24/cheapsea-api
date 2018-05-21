require 'rails_helper'

describe ThirdParty::Travelpayouts::GetCitiesService do
  subject do
    ThirdParty::Travelpayouts::GetCitiesService.new.call
  end

  use_vcr_cassette 'services/third_party/travelpayouts/get_cities_service'

  it 'checks that result is not empty' do
    expect(subject).not_to be_empty
  end
end
