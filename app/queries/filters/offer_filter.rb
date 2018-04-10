class Filters::OfferFilter < Filters::Base
  def initialize(params)
    super(params)
    @relation = Offer.includes(:airline, :user, transfers: :airline)
  end
end
