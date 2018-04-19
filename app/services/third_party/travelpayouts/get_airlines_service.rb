module ThirdParty::Travelpayouts::GetAirlinesService
  def self.call
    response = HTTParty.get("#{ENV['TRAVELPAYOUTS_URL']}/data/airlines.json")
    JSON.parse(response.body)
  end
end
