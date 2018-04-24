namespace :import do
  desc 'Import'

  task all: :environment do
    Rake::Task['import:airlines'].invoke
    Rake::Task['import:cities'].invoke
    Rake::Task['import:two_sides_cheapest_offers'].invoke
    #Rake::Task['import:one_side_cheapest_offers'].invoke
  end

  task airlines: :environment do
    Import::AirlinesService.call
  end

  task cities: :environment do
    Import::CitiesService.call
  end

  task two_sides_cheapest_offers: :environment do
    Import::TwoSidesCheapestOffersWorker.perform_async
  end

  task one_side_cheapest_offers: :environment do
    Import::OneSideCheapestOffersWorker.perform_async
  end
end
