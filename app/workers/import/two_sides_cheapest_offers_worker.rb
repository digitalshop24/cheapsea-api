class Import::TwoSidesCheapestOffersWorker
  include Sidekiq::Worker

  def perform
    cities = CityCode.all
    user = User.admin.take

    cities.each_with_index do |first_level_city, index|
      puts "#{first_level_city.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |second_level_city|
        next if first_level_city.id == second_level_city.id

        begin
          offers = ::ThirdParty::Travelpayouts::GetTwoSidesCheapestOffersService.call(origin: first_level_city.iata, destination: second_level_city.iata)
        rescue  Exception => e
          raise e.message
        end

        next if offers['data'].empty?

        # > offers['data']
        # > {"NYC"=>{"1"=>{"price"=>23691, "airline"=>"N7", "flight_number"=>704, "departure_at"=>"2018-09-12T06:00:00Z",
        offers['data'][second_level_city.iata].each do |offer|
          data = offer.second

          next if Offer.where(
            flight_number: data['flight_number'],
            date_from: data['departure_at'],
            date_to: data['return_at'],
            two_sides: true
          ).any?

          begin
            from_google_place = ::ThirdParty::Geo::AutocompleteService.new(first_level_city.name).call.first
            to_google_place = ::ThirdParty::Geo::AutocompleteService.new(second_level_city.name).call.first

            Offer.create(
              offer_type: 'airplane',
              two_sides: true,
              user: user,
              price: data['price'],
              name: "From #{first_level_city.name} to #{second_level_city.name} for #{data['price']} RUB.",
              from_google_place_id: from_google_place['place_id'],
              to_google_place_id: to_google_place['place_id'],
              airline: Airline.find_by(iata: data['airline']),
              date_from: data['departure_at'],
              date_to: data['return_at'],
              date_end: data['expires_at']
            )
          rescue Exception => e
            ThirdParty::RaiseErrorService.call(self, { error: e.message })

            next
          end
        end
      end
    end
  end
end
