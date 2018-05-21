class ThirdParty::Travelpayouts::GetCitiesService < ThirdParty::Base
  def call
    response = get_url('/data/cities.json')
    JSON.parse(response.body)
  end
end
