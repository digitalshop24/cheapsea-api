class Import::OneSideCheapestOfferWorker
  include Sidekiq::Worker

  def perform(google_places)
    Import::Offers::OneSideCheapestOfferService.new(google_places: google_places).call
  end
end
