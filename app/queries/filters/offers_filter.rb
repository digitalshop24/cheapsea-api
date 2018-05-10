class Filters::OffersFilter < Filters::Base
  def initialize(params, page)
    super(params, page)
  end

  def call
    super

    filter_by_name if complex_params[:name].present?

    results&.page(page)
  end

  private

  def relation
    Offer.includes(
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
    )
  end

  def simple_acessible_params
    %i[offer_type discount_type airline_id transfers_count date_from date_to date_end price price_currency discount_rate two_sides origin_id destination_id]
  end

  def complex_acessible_params
    %i[name]
  end

  def filter_by_name
    name = complex_params[:name]
    @results = results.where('name ILIKE ? or name_auto ILIKE ?', "%#{name}%", "%#{name}%")
  end
end
