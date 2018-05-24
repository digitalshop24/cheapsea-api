module Import::CitiesService
  class << self
    def call
      cities = ::ThirdParty::Travelpayouts::GetCitiesService.new.call

      puts 'Cities import started'

      cities.each_with_index do |city, index|
        puts "#{index}/#{cities.length} cities imported" if index % 1000 == 0

        name = city['name_translations']['ru']

        next if City.find_by(name: city['name'], iata: city['code']).present?

        created_city = City.create!(
          iata: city['code'],
          name: name,
          name_en: city['name'],
          active: is_active?(city['code']),
          country: Country.find_by(iata: city['country_code']),
          latitude: city.dig('coordinates', 'lat'),
          longitude: city.dig('coordinates', 'lon'))

        update_country_continent(created_city, city['time_zone'])
      end

      puts "#{City.count} cities imported"
    end

    def update_country_continent(city, time_zone)
      return if city.nil?

      continent = Continent.find_or_create_by(name: time_zone.split('/').first)

      city.country.update(continent: continent)
    end

    def is_active?(iata)
      Cities::TopHundredValueObject.iata_include?(iata)
    end
  end
end
