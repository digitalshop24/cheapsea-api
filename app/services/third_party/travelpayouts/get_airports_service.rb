class ThirdParty::Travelpayouts::GetAirportsService < ThirdParty::Base
  def call
    response = get_url('/data/airports.json')
    JSON.parse(response.body)
  end
end
