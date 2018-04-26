class Import::OneSideCheapestOfferWorker
  include Sidekiq::Worker

  def perform(origin_id, destination_id)
    origin = City.find(origin_id)
    destination = City.find(destination_id)
    Import::Offers::OneSideCheapestOfferService.new(origin, destination).call
  end
end
