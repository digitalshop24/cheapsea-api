class ThirdParty::Geo::AutocompleteService < ThirdParty::Geo::Base
  def initialize(input)
    @input = input
  end

  def call
    result = read_from_cache
    if result.nil?
      url = "#{ENV['GOOGLE_MAP_URL']}/place/autocomplete/json?input=#{input}&types=geocode&key=#{ENV['GOOGLE_MAP_KEY']}"

      result = get_url(url)

      add_to_cache(result)
    end

    result = JSON.parse(result)

    ThirdParty::RaiseErrorService.call(self.class.name, result, true)

    return result['predictions']
  end

  private

  def read_from_cache
    ReadCache.redis.hget('google_place_names_cache', input)
  end

  def add_to_cache(result)
    return if result['error_message'].present? || result['predictions'].empty?

    ReadCache.redis.hset('google_place_names_cache', input, result)
  end

  attr_reader :input
end
