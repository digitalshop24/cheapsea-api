namespace :import do
  desc 'Import'

  task all: :environment do
    Rake::Task['import:airlines'].invoke
    Rake::Task['import:city_codes'].invoke
  end

  task airlines: :environment do
    airlines_array = Airlines::GetAllService.call

    puts 'Airlines import started'

    airlines_array.each_with_index do |airline, index|
      next if Airline.find_by(name: airline['name']).present?

      puts "#{index}/#{airlines_array.length} airlines imported" if index % 1000 == 0

      Airline.create!(name: airline['name'])
    end

    puts "#{Airline.count} airlines imported"
  end

  task city_codes: :environment do
    CityCode.delete_all

    puts 'Airlines import started'

    city_codes = JSON.parse(File.read("#{Rails.root}/lib/import/city_codes.json"))
    available_cities = CityCodes::TopHundredValueObject.call

    city_codes.each do |code|
      iata = code.first
      name = code.second['name']

      next unless available_cities.include?(name)

      CityCode.create!(iata: iata, name: name)
    end

    puts "#{CityCode.count} city codes imported"
  end
end
