class Import::OneSideCheapestOffersWorker
  include Sidekiq::Worker

  def perform
    Import::Offers::OneSideCheapestOffersService.new.call
  end
end
