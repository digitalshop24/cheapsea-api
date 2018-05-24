module Import::AirportsService
  def self.call
    airports = ::ThirdParty::Travelpayouts::GetAirportsService.new.call

    puts 'Airports import started'

    airports.each_with_index do |airport, index|
      next if Airport.find_by(name: airport['name'], iata: airport['code']).present?

      puts "#{index}/#{airports.length} airports imported" if index % 1000 == 0

      Airport.create!(
        name: airport['name_translations']['ru'],
        name_en: airport['name'],
        iata: airport['code'],
        city: City.find_by(iata: airport['city_code']),
        latitude: airport.dig('coordinates', 'lat'),
        longitude: airport.dig('coordinates', 'lon')
      )
    end

    puts "#{Airport.count} airports imported"
  end
end
