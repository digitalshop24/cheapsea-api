namespace :import do
  desc 'Import'
  task airlines: :environment do
    Airline.destroy_all
    airlines_array = Airlines::GetAllService.call

    puts 'Import started'

    airlines_array.each_with_index do |airline, index|
      next if Airline.where(name: airline['name']).any?

      puts "#{index}/#{airlines_array.length} imported" if index % 1000 == 0

      Airline.create!(name: airline['name'])
    end

    puts 'Import finished'
  end
end
