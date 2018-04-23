# TODO add specs
module ThirdParty::Travelpayouts::GetOneSideCheapestOffersService
  def self.call(origin:, destination:, month: Date.current)
    url = "#{ENV['TRAVELPAYOUTS_URL']}/v2/prices/month-matrix?origin=#{origin}&destination=#{destination}&month=#{month}&show_to_affiliates=false&token=#{ENV['TRAVELPAYOUTS_KEY']}"
    response = HTTParty.get(url)
    result = JSON.parse(response.body)

    ThirdParty::RaiseErrorService.call(self, result, true)

    result
  end
end
