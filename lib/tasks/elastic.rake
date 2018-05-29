namespace :elastic_import do
  task all: :environment do
    Rake::Task['elastic_import:cities'].invoke
    Rake::Task['elastic_import:airports'].invoke
    Rake::Task['elastic_import:airlines'].invoke
  end

  task cities: :environment do
    CitiesIndex.purge!
    CitiesIndex.import!
    puts 'CitiesIndex imported'
  end

  task airports: :environment do
    AirportsIndex.purge!
    AirportsIndex.import!
    puts 'AirportsIndex imported'
  end

  task airlines: :environment do
    AirlinesIndex.purge!
    AirlinesIndex.import!
    puts 'AirlinesIndex imported'
  end

  task offers: :environment do
    OffersIndex.purge!
    OffersIndex.import!
    puts 'OffersIndex imported'
  end

  task offer_collections: :environment do
    OfferCollectionsIndex.purge!
    OfferCollectionsIndex.import!
    puts 'OfferCollections imported'
  end
end
