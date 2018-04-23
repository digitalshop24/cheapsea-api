namespace :import do
  desc 'Import'

  task all: :environment do
    Rake::Task['import:airlines'].invoke
    Rake::Task['import:city_codes'].invoke
    Rake::Task['import:two_sides_cheapest_offers'].invoke
    Rake::Task['import:one_side_cheapest_offers'].invoke
  end

  task airlines: :environment do
    Import::AirlinesWorker.perform_async
  end

  task city_codes: :environment do
    Import::CityCodesService.call
  end

  task two_sides_cheapest_offers: :environment do
    Import::TwoSidesCheapestOffersWorker.perform_async
  end

  task one_side_cheapest_offers: :environment do
    Import::OneSideCheapestOffersWorker.perform_async
  end
end
