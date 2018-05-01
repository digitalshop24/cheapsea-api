module Import::CitiesService
  def self.call
    return if City.any?

    puts 'Cities import started'

    cities = JSON.parse(File.read("#{Rails.root}/lib/import/cities.json"))
    active_cities = Cities::TopHundredValueObject.call

    cities.each_with_index do |city, index|
      puts "#{index}/#{cities.length} cities imported" if index % 1000 == 0

      name = city['name_translations']['ru']

      City.create!(
        iata: city['code'],
        name: name,
        name_en: city['name'],
        active: active_cities.include?(name),
        country: Country.find_by(iata: city['country_code']),
        latitude: city.dig('coordinates', 'lat'),
        longitude: city.dig('coordinates', 'lon'))
    end

    puts "#{City.count} cities imported"
  end
end
