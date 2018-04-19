module ThirdParty::Travelpayouts::GetCheapOffersService
  def self.call(origin:, destination:)
    response = HTTParty.get("#{ENV['TRAVELPAYOUTS_URL']}/v1/prices/cheap?origin=#{origin}&destination=#{destination}&token=#{ENV['TRAVELPAYOUTS_KEY']}")
    JSON.parse(response.body)
  end
end
