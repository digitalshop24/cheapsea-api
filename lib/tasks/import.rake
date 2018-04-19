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

    puts 'Airlines import finished'
  end

  task city_codes: :environment do
    return if CityCode.any?

    puts 'Airlines import started'

    city_codes = JSON.parse(File.read("#{Rails.root}/lib/import/city_codes.json"))

    city_codes.each_with_index do |code, index|
      puts "#{index}/#{city_codes.length} city codes imported" if index % 500 == 0

      CityCode.create!(iata: code.first, name: code.second['name'])
    end

    puts 'City codes import finished'
  end
end
