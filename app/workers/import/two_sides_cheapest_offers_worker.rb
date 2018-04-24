class Import::TwoSidesCheapestOffersWorker
  include Sidekiq::Worker

  def perform
    Import::Offers::TwoSidesCheapestOffersService.new.call
  end
end
