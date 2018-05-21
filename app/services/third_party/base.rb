class ThirdParty::Base
  protected

  def get_url(url)
    HTTParty.get("#{ENV['TRAVELPAYOUTS_URL']}#{url}")
  end
end
