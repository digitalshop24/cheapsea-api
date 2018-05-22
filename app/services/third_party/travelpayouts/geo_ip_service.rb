module ThirdParty::Travelpayouts::GeoIpService
  def self.call(ip)
    url = "http://www.travelpayouts.com/whereami?locale=ru&ip=#{ip}"
    response = HTTParty.get(url)
    JSON.parse(response.body)
  end
end
