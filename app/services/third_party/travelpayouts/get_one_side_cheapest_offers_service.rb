class ThirdParty::Travelpayouts::GetOneSideCheapestOffersService < ThirdParty::Base
  include Interactor

  def call
    pre_initialize

    url = "#{ENV['TRAVELPAYOUTS_URL']}/v2/prices/month-matrix?origin=#{origin}&destination=#{destination}&month=#{month}&show_to_affiliates=false&token=#{ENV['TRAVELPAYOUTS_KEY']}"
    response = get_url(url)
    result = JSON.parse(response.body)
    context.fail!(error: result['errors']) if result['errors'].present?
    context.fail!(error: result['message']) if result['message'].present?
    context.fail!(error: result['data']['errors']) if result['data'].is_a?(Hash) && result['data'].has_key?('errors')

    context.result = result['data']
  end

  private

  def pre_initialize
    @origin = context.origin
    @destination = context.destination
    @month = context.month
  end

  attr_reader :origin, :destination, :month
end
