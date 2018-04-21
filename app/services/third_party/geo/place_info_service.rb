class ThirdParty::Geo::PlaceInfoService < ThirdParty::Geo::Base
  include Interactor

  def call
    pre_initialize

    result = read_from_cache
    if result.nil?
      url = "#{ENV['GOOGLE_MAP_URL']}/geocode/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAP_KEY']}"

      begin
        result = get_url(url)
      rescue Exception => e
        context.fail!(error: e.message)
      end

      add_to_cache(result)
    end

    context.result = JSON.parse(result)['results'][0]
  end

  private

  def pre_initialize
    @place_id = context.place_id
  end

  def read_from_cache
    ReadCache.redis.hget('google_place_ids_cache', place_id)
  end

  def add_to_cache(result)
    error = JSON.parse(result)['error_message']
    context.fail!(error: error) if error.present?

    ReadCache.redis.hset('google_place_ids_cache', place_id, result)
  end

  attr_reader :place_id
end
