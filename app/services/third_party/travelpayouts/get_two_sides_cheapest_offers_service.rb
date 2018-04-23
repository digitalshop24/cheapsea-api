class ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService < ThirdParty::Base
  include Interactor

  def call
    pre_initialize

    url = "#{ENV['TRAVELPAYOUTS_URL']}/v1/prices/cheap?origin=#{origin}&destination=#{destination}&token=#{ENV['TRAVELPAYOUTS_KEY']}"
    response = get_url(url)
    result = JSON.parse(response.body)
    context.fail!(error: result['error'] || result['message']) unless result['success']

    context.result = result['data']
  end

  private

  def pre_initialize
    @origin = context.origin
    @destination = context.destination
  end

  attr_reader :origin, :destination
end
