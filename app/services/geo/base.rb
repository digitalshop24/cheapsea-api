class Geo::Base
  protected

  def get_url(url)
    url = URI.parse(URI.encode(url))
    req = Net::HTTP::Get.new(url.to_s)
    result = Net::HTTP.start(url.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) { |http| http.request(req) }

    return unless result.code == '200'
    result.body.force_encoding('utf-8')
  end
end