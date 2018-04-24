class Import::Offers::TwoSidesCheapestOffersService
  def call
    cities = City.active
    user = User.admin.take

    cities.each_with_index do |origin, index|
      puts "#{origin.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |destination|
        next if the_same_point?

        offers = fetch_offers(origin, destination)

        next if offers.empty?

        # > offers
        # > {"NYC"=>{"1"=>{"price"=>23691, "airline"=>"N7", "flight_number"=>704, "departure_at"=>"2018-09-12T06:00:00Z",
        # NYC is destination.iata
        offers[destination.iata].each do |offer|
          data = offer.second

          next if offer_exists?(data)

          begin
            from_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: origin.name).result
            to_google_place_service = ::ThirdParty::Geo::AutocompleteService.call(input: destination.name).result
            next if from_google_place_service.nil? && to_google_place_service.nil?

            Offer.create!(
              offer_type: 'airplane',
              two_sides: true,
              user: user,
              price: data['price'],
              name: "From #{origin.name} to #{destination.name} for #{data['price']} RUB.",
              from_google_place_id: from_google_place_service.first['place_id'],
              to_google_place_id: to_google_place_service.first['place_id'],
              airline: Airline.find_by(iata: data['airline']),
              date_from: data['departure_at'],
              date_to: data['return_at'],
              date_end: data['expires_at']
            )
          rescue Exception => e
            logger.warn e

            next
          end
        end
      end
    end
  end

  private

  def the_same_point?(origin, destination)
    origin.id == destination.id
  end

  def fetch_offers(origin, destination)
    get_two_sides_offers_service = ::ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService.call(origin: origin.iata, destination: destination.iata)

    context.fail!(error: get_two_sides_offers_service.error) if get_two_sides_offers_service.failure?

    @offers = get_two_sides_offers_service.result
  end

  def offer_exists?(data)
    Offer.two_sides.find_by(
      price: data['price'],
      date_from: data['departure_at'],
      date_to: data['return_at']
    ).present?
  end
end
