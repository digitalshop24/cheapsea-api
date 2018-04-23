module ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService
  def self.call(origin:, destination:)
    url = "#{ENV['TRAVELPAYOUTS_URL']}/v1/prices/cheap?origin=#{origin}&destination=#{destination}&token=#{ENV['TRAVELPAYOUTS_KEY']}"
    response = HTTParty.get(url)
    result = JSON.parse(response.body)

    ThirdParty::RaiseErrorService.call(self, result, true)

    result
  end
end
