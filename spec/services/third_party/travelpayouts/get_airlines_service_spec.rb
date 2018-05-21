require 'rails_helper'

describe ThirdParty::Travelpayouts::GetAirlinesService do
  subject do
    ThirdParty::Travelpayouts::GetAirlinesService.new.call
  end

  use_vcr_cassette 'services/third_party/travelpayouts/get_airlines_service'

  it 'checks that result is not empty' do
    expect(subject).not_to be_empty
  end
end
