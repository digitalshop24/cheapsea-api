require 'rails_helper'

describe ThirdParty::Travelpayouts::GeoIpService do
  subject do
    ThirdParty::Travelpayouts::GeoIpService.call(ip)
  end

  let(:ip) { '185.156.174.178' }

  use_vcr_cassette 'services/third_party/travelpayouts/geo_ip_service'

  it 'checks that result is not empty' do
    expect(subject).not_to be_empty
  end

  it 'checks that response has a particular data' do
    expect(subject['iata']).to eq('PRG')
  end
end
