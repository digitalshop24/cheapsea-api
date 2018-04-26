# TODO add specs

class ThirdParty::Geo::PlaceIdsFromNamesService
  include Interactor

  def call
    pre_initialize

    from_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: origin_name)
    context.fail!(error: from_google_place_service.error) if from_google_place_service.failure?
    context.fail!(error: 'from_google_place_is is nil') if from_google_place_service.result.first.nil?

    to_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: destination_name)
    context.fail!(error: to_google_place_service.error) if to_google_place_service.failure?
    context.fail!(error: 'to_google_place_is is nil') if to_google_place_service.result.first.nil?

    result = {
      from_google_place_id: from_google_place_service.result.first['place_id'],
      to_google_place_id: to_google_place_service.result.first['place_id']
    }

    context.result = result
  end

  private

  attr_reader :origin_name, :destination_name

  def pre_initialize
    @origin_name = context.origin_name
    @destination_name = context.destination_name

    context.fail!(error: 'There should be 2 values') if origin_name.nil? || destination_name.nil?
  end
end
