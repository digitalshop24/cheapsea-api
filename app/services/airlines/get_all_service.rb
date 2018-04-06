class Airlines::GetAllService
  def self.call
    response = HTTParty.get('http://api.travelpayouts.com/data/airlines.json')
    JSON.parse(response.body)
  end
end
