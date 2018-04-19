class ThirdParty::Geo::AutocompleteService < ThirdParty::Geo::Base
  def initialize(input, lat = nil, lng = nil)
    @input = input
    @lat = lat
    @lng = lng
  end

  def call
    url = "#{ENV['GOOGLE_MAP_URL']}/place/autocomplete/json?input=#{input}&types=geocode&key=#{ENV['GOOGLE_MAP_KEY']}"
    url << "&location=#{lat},#{lng}&radius=999" if lat.present? && lng.present?

    delete_words = ['id', 'matched_substrings', 'reference', 'structured_formatting']

    result = get_url(url)

    predictions = JSON.parse(result)['predictions']
    predictions.each { |h| delete_words.each { |v| h.delete(v) } }

    return predictions
  end

  private

  attr_reader :input, :lat, :lng
end
