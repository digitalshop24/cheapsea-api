module ThirdParty::Travelpayouts::GetAirportsService
  def self.call
    response = HTTParty.get("#{ENV['TRAVELPAYOUTS_URL']}/data/airports.json")
    JSON.parse(response.body)
  end
end
