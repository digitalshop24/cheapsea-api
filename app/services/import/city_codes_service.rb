module Import::CityCodesService
  def self.call
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
end