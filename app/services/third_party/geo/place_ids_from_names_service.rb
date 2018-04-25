# TODO add specs

class ThirdParty::Geo::PlaceIdsFromNamesService
  include Interactor

  def call
    pre_initialize

    begin
      result = {
        from_google_place_id: ::ThirdParty::Geo::AutocompleteService.call(input: origin).result.first['place_id'],
        to_google_place_id: ::ThirdParty::Geo::AutocompleteService.call(input: destination).result.first['place_id']
      }
    rescue Exception => e
      context.fail!(error: e)
    end

    context.result = result
  end

  private

  attr_reader :origin, :destination

  def pre_initialize
    @origin = context.origin
    @destination = context.destination
  end
end
