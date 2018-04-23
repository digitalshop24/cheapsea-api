class Import::AirlinesWorker
  include Sidekiq::Worker

  def perform
    airlines_array = ::ThirdParty::Travelpayouts::GetAirlinesService.call

    puts 'Airlines import started'

    airlines_array.each_with_index do |airline, index|
      next if Airline.find_by(name: airline['name']).present?

      puts "#{index}/#{airlines_array.length} airlines imported" if index % 1000 == 0

      Airline.create!(name: airline['name'], iata: airline['iata'])
    end

    puts "#{Airline.count} airlines imported"
  end
end
