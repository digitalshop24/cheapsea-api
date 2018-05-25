class OffersIndex < Chewy::Index
  define_type Offer.includes(:origin, :destination) do
    field :id
    field :origin_city_id, value: -> { origin_id }, type: 'integer'
    field :destination_city_id, value: -> { destination_id }, type: 'integer'
    field :origin_country_id, value: ->(offer) { offer&.origin&.country_id }, type: 'integer'
    field :destination_country_id, value: ->(offer) { offer&.destination&.country_id }, type: 'integer'
  end
end
