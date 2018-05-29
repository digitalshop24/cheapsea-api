class OffersFilterQuery < Filtering::Base
  def initialize(params, args)
    super(params, args)
  end

  def call
    super

    result.includes(
      :airline,
      :user,
      :from_airport,
      :to_airport,
      :images_countries_rectangular,
      :images_countries_square,
      :tags,
      :collections,
      origin: [country: :continent],
      destination: [country: :continent],
      transfers: [:airline]
    )
  end

  private

  # Required methods

  def relation
    offers = Offer.all

    filtered_by_elastic_ids = OffersSearch.new(params).call
    offers = offers.where(id: filtered_by_elastic_ids) if filtered_by_elastic_ids.present?

    offers
  end

  def plain_acessible_params
    %i[offer_type discount_type airline_id transfers_count date_from date_to date_end price_currency discount_rate two_sides main]
  end

  def complex_acessible_params
    %i[name price]
  end

  # Complex filters

  def filter_by_name(name)
    result.where('name ILIKE ? or name_auto ILIKE ?', "%#{name}%", "%#{name}%")
  end

  def filter_by_price(price)
    splitted = price.try(:split, '-')
    if splitted.present? && splitted.length == 2
      result.where(price: splitted[0]..splitted[1])
    else
      result.where(price: price)
    end
  end

  def filter_by_collection_id(id)
    result.joins(:collections).where(collections: { id: id })
  end
end
