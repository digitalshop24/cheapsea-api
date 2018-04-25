class Import::Offers::OneSideCheapestOffersService
  def call
    cities = City.active

    cities.each_with_index do |origin, index|
      puts "#{origin.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |destination|
        next if the_same_point?(origin, destination)

        google_places_service = google_places_info_service(origin, destination)
        next if google_places_service.failure?
        google_places = google_places_service.result

        next if any_draft_offers?(google_places)

        Import::Offers::OneSideCheapestOfferService.new(origin: origin, destination: destination, google_places: google_places).call
      end
    end
  end

  private

  def the_same_point?(origin, destination)
    origin.id == destination.id
  end

  def any_draft_offers?(google_places)
    Offer.draft.one_side.find_by(
      from_google_place_id: google_places[:from_google_place_id],
      to_google_place_id: google_places[:to_google_place_id]
    ).present?
  end

  def google_places_info_service(origin, destination)
    ThirdParty::Geo::PlaceIdsFromNamesService.call(origin: origin.name, destination: destination.name)
  end
end
