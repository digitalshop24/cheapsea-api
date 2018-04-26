# TODO add specs

class ThirdParty::Geo::PlaceIdsFromNamesService
  include Interactor

  def call
    pre_initialize

    from_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: origin)
    context.fail!(error: from_google_place_service.error) if from_google_place_service.failure?
    context.fail!(error: 'from_google_place_is is nil') if from_google_place_service.result.first.nil?

    to_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: destination)
    context.fail!(error: to_google_place_service.error) if to_google_place_service.failure?
    context.fail!(error: 'to_google_place_is is nil') if to_google_place_service.result.first.nil?

    result = {
      from_google_place_id: from_google_place_service.result.first['place_id'],
      to_google_place_id: to_google_place_service.result.first['place_id']
    }

    context.result = result
  end

  private

  attr_reader :origin, :destination

  def pre_initialize
    @origin = context.origin
    @destination = context.destination

    context.fail!(error: 'There should be 2 values') if origin.nil? || destination.nil?
  end
end
