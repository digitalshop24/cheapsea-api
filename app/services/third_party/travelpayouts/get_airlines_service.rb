class ThirdParty::Travelpayouts::GetAirlinesService < ThirdParty::Base
  def call
    response = get_url('/data/airlines.json')
    JSON.parse(response.body)
  end
end
