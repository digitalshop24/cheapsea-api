class ThirdParty::Geo::PlaceInfoService < ThirdParty::Base
  include Interactor

  def call
    pre_initialize

    result = read_from_cache
    if result.nil?
      url = "#{ENV['GOOGLE_MAP_URL']}/geocode/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAP_KEY']}&language=ru"
      result = get_url(url)
      context.fail!(error: result['error_message']) if result['error_message'].present?

      add_to_cache(result)
    end

    if result.is_a?(HTTParty::Response)
      context.result = result.parsed_response['results'][0]
    else
      context.result = JSON.parse(result)['results'][0]
    end
  end

  private

  def pre_initialize
    @place_id = context.place_id
  end

  def read_from_cache
    ReadCache.redis.hget('google_place_ids_cache', place_id)
  end

  def add_to_cache(result)
    return if result['results'].empty?

    ReadCache.redis.hset('google_place_ids_cache', place_id, result)
  end

  attr_reader :place_id
end
