class ThirdParty::Geo::AutocompleteService < ThirdParty::Base
  include Interactor

  def call
    pre_initialize

    result = read_from_cache
    if result.nil?
      url = "#{ENV['GOOGLE_MAP_URL']}/place/autocomplete/json?input=#{input}&types=geocode&key=#{ENV['GOOGLE_MAP_KEY']}"
      result = get_url(URI.parse(URI.escape(url)))
      context.fail!(error: result['error_message']) if result['error_message'].present?

      add_to_cache(result)
    end

    context.result = JSON.parse(result['predictions'].to_json)
  end

  private

  def pre_initialize
    @input = context.input
  end

  def read_from_cache
    ReadCache.redis.hget('google_place_names_cache', input)
  end

  def add_to_cache(result)
    return if result['predictions'].empty?

    ReadCache.redis.hset('google_place_names_cache', input, result)
  end

  attr_reader :input
end
