module ThirdParty::Travelpayouts::GetCitiesService
  def self.call
    response = HTTParty.get("#{ENV['TRAVELPAYOUTS_URL']}/data/cities.json")
    JSON.parse(response.body)
  end
end
