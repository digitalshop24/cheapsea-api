namespace :import do
  desc 'Import'

  task all: :environment do
    Rake::Task['import:airlines'].invoke
    Rake::Task['import:city_codes'].invoke
  end

  task airlines: :environment do
    airlines_array = ThirdParty::Travelpayouts::GetAirlinesService.call

    puts 'Airlines import started'

    airlines_array.each_with_index do |airline, index|
      next if Airline.find_by(name: airline['name']).present?

      puts "#{index}/#{airlines_array.length} airlines imported" if index % 1000 == 0

      Airline.create!(name: airline['name'], iata: airline['iata'])
    end

    puts "#{Airline.count} airlines imported"
  end

  task city_codes: :environment do
    CityCode.delete_all

    puts 'Airlines import started'

    city_codes = JSON.parse(File.read("#{Rails.root}/lib/import/city_codes.json"))
    popular_cities = CityCodes::TopHundredValueObject.call

    city_codes.each do |code|
      iata = code.first
      name = code.second['name']

      next unless popular_cities.include?(name)

      CityCode.create!(iata: iata, name: name)
    end

    puts "#{CityCode.count} city codes imported"
  end

  task cheap_offers: :environment do
    cities = CityCode.all
    user = User.admin.take

    cities.each_with_index do |first_level_city, index|
      puts "#{first_level_city.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |second_level_city|
        offers = ThirdParty::Travelpayouts::GetCheapOffersService.call(origin: first_level_city.iata, destination: second_level_city.iata)

        next if offers['data'].empty?

        # > offers['data']
        # > {"NYC"=>{"1"=>{"price"=>23691, "airline"=>"N7", "flight_number"=>704, "departure_at"=>"2018-09-12T06:00:00Z",
        offers['data'][second_level_city.iata].each do |offer|
          data = offer.second

          next if Offer.find_by(flight_number: data['flight_number']).present?

          from_google_place_id = ThirdParty::Geo::AutocompleteService.new(first_level_city.name).call
          to_google_place_id = ThirdParty::Geo::AutocompleteService.new(second_level_city.name).call
          next if from_google_place_id.nil? || to_google_place_id.nil?

          Offer.create(
            two_sides: true,
            user: user,
            price: data['price'],
            name: "From #{first_level_city.name} to #{second_level_city.name} for #{data['price']} RUB.",
            from_google_place_id: from_google_place_id['place_id'],
            to_google_place_id: to_google_place_id['place_id'],
            airline: Airline.find_by(iata: data['airline']),
            date_from: data['departure_at'],
            date_to: data['return_at'],
            date_end: data['expires_at']
          )
        end
      end
    end
  end
end
