module Import::AirlinesService
  def self.call
    airlines = ::ThirdParty::Travelpayouts::GetAirlinesService.new.call

    puts 'Airlines import started'

    airlines.each_with_index do |airline, index|
      next if Airline.find_by(name: airline['name']).present?

      puts "#{index}/#{airlines.length} airlines imported" if index % 1000 == 0

      Airline.create!(name: airline['name'], iata: airline['iata'])
    end

    puts "#{Airline.count} airlines imported"
  end
end
