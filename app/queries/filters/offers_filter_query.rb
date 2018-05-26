class OffersFilterQuery < Filtering::Base
  def initialize(params, args)
    super(params, args)
  end

  private

  # Required methods

  def relation
    offers = Offer.includes(
      :airline,
      :user,
      :from_airport,
      :to_airport,
      :images_countries_rectangular,
      :images_countries_square,
      :tags,
      origin: [country: :continent],
      destination: [country: :continent],
      transfers: [:airline],
    )

    filtered_by_elastic_ids = OffersSearch.new(params).call
    offers = offers.where(id: filtered_by_elastic_ids) if filtered_by_elastic_ids.any?

    offers
  end

  def plain_acessible_params
    %i[offer_type discount_type airline_id transfers_count date_from date_to date_end price price_currency discount_rate two_sides]
  end

  def complex_acessible_params
    %i[name]
  end

  # Complex filters

  def filter_by_name(name)
    results.where('name ILIKE ? or name_auto ILIKE ?', "%#{name}%", "%#{name}%")
  end
end
