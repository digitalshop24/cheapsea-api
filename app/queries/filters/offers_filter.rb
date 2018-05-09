class Filters::OffersFilter < Filters::Base
  def initialize(params, page)
    super(params, page)
    @relation = Offer.includes(
      :airline,
      :user,
      :from_airport,
      :to_airport,
      :images_countries_rectangular,
      :images_countries_square,
      :tags,
      origin: [country: :continent],
      destination: [country: :continent],
      transfers: [:airline, :city]
    ).page(page)
  end
end
