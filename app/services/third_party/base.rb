class ThirdParty::Base
  protected

  def get_url(url)
    HTTParty.get(url)
  end
end
