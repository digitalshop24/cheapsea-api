namespace :import do
  desc 'Import'

  task countries: :environment do
    Import::CountriesService.call
  end

  task cities: :environment do
    Import::CitiesService.call
  end

  task airports: :environment do
    Import::AirportsService.call
  end

  task airlines: :environment do
    Import::AirlinesService.call
  end

  task two_sides_cheapest_offers: :environment do
    Import::TwoSidesCheapestOffersWorker.perform_async
  end

  task one_side_cheapest_offers: :environment do
    Import::OneSideCheapestOffersWorker.perform_async
  end
end
