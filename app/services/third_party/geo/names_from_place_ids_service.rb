# TODO add specs

class ThirdParty::Geo::NamesFromPlaceIdsService
  include Interactor

  def call
    pre_initialize

    begin
      result = {
        origin: ThirdParty::Geo::PlaceInfoService.call(place_id: from_google_place_id).result['address_components'][0]['long_name'],
        destination: ThirdParty::Geo::PlaceInfoService.call(place_id: to_google_place_id).result['address_components'][0]['long_name']
      }
    rescue Exception => e
      context.fail!(error: e)
    end

    context.result = result
  end

  private

  attr_reader :from_google_place_id, :to_google_place_id

  def pre_initialize
    @from_google_place_id = context.google_places[:from_google_place_id]
    @to_google_place_id = context.google_places[:to_google_place_id]
  end
end
