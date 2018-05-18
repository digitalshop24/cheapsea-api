class Import::Offers::TwoSidesCheapestOffersService
  def call
    cities = City.active
    user = User.admin.take

    cities.each_with_index do |origin, index|
      puts "#{self.class.name} | #{origin.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |destination|
        next if the_same_point?(origin.id, destination.id)

        offers = fetch_offers(origin, destination)

        next if offers.empty?

        # > offers
        # > {"NYC"=>{"1"=>{"price"=>23691, "airline"=>"N7", "flight_number"=>704, "departure_at"=>"2018-09-12T06:00:00Z",
        # NYC is destination.iata
        offers[destination.iata].each do |offer|
          data = offer.second

          next if offer_exists?(origin, destination, data)

          begin
            Offer.create!(
              offer_type: 'airplane',
              two_sides: true,
              user: user,
              airline: Airline.find_by(iata: data['airline']),
              date_from: data['departure_at'],
              date_to: data['return_at'],
              date_end: data['expires_at'],
              origin: origin,
              destination: destination
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

  def the_same_point?(origin_id, destination_id)
    origin_id == destination_id
  end

  def fetch_offers(origin, destination)
    get_two_sides_offers_service = ::ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService.call(origin: origin.iata, destination: destination.iata)

    context.fail!(error: get_two_sides_offers_service.error) if get_two_sides_offers_service.failure?

    @offers = get_two_sides_offers_service.result
  end

  def offer_exists?(origin, destination, data)
    Offer.two_sides.find_by(
      origin_id: origin.id,
      destination_id: destination.id,
      price: data['price'],
      date_from: data['departure_at'],
      date_to: data['return_at']
    ).present?
  end
end
