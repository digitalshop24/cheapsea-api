class Import::OneSideCheapestOffersWorker
  include Sidekiq::Worker

  def perform
    cities = CityCode.all
    user = User.admin.take

    cities.each_with_index do |first_level_city, index|
      puts "#{first_level_city.name} - #{index + 1}/#{cities.length} checking..."

      cities.find_each do |second_level_city|
        next if first_level_city.id == second_level_city.id

        offers = ::ThirdParty::Travelpayouts::GetOneSideCheapestOffersService.call(origin: first_level_city.iata, destination: second_level_city.iata)

        next if offers['data'].empty?
      end
    end
  end
end
