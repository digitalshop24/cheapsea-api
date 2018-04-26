class ThirdParty::Geo::NamesFromPlaceIdsService
  include Interactor

  def call
    pre_initialize

    origin_service = ThirdParty::Geo::PlaceInfoService.call(place_id: from_google_place_id)
    context.fail!(error: origin_service.error) if origin_service.failure?
    origin = origin_service.result['address_components'][0]['long_name']
    context.fail!(error: 'origin is nil') if origin.nil?

    destination_service = ThirdParty::Geo::PlaceInfoService.call(place_id: to_google_place_id)
    context.fail!(error: destination_service.error) if destination_service.failure?
    destination = destination_service.result['address_components'][0]['long_name']
    context.fail!(error: 'destination is nil') if destination.nil?

    result = {
      origin: origin,
      destination: destination
    }

    context.result = result
  end

  private

  attr_reader :from_google_place_id, :to_google_place_id

  def pre_initialize
    @from_google_place_id = context.from_google_place_id
    @to_google_place_id = context.to_google_place_id
  end
end
