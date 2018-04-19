class ThirdParty::Geo::PlaceInfoService < ThirdParty::Geo::Base
  include Interactor

  def call
    pre_initialize

    res = read_from_cache
    if res.nil?
      url = "#{ENV['GOOGLE_MAP_URL']}/geocode/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAP_KEY']}"

      res = get_url(url)

      add_to_cache(res)
    end

    begin
      result = JSON.parse(res)['results'][0]
    rescue Exception => e
      context.fail!(error: e.message)
    end

    context.result = result
  end

  private

  def pre_initialize
    @place_id = context.place_id
  end

  def read_from_cache
    ReadCache.redis.hget('google_places_cache', place_id)
  end

  def add_to_cache(result)
    ReadCache.redis.hset('google_places_cache', place_id, result)
  end

  attr_reader :place_id
end
