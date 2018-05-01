class Filters::OffersFilter < Filters::Base
  def initialize(params, page)
    super(params, page)
    @relation = Offer.includes(:airline, :user, transfers: :airline).page(page)
  end
end
