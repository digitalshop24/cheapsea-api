class OfferSerializer < ActiveModel::Serializer
  attributes :id,
    :offer_type,
    :discount_type,
    :name,
    :from_google_place_id,
    :to_google_place_id,
    :airline_id,
    :flight_type,
    :transfers_count,
    :date_from,
    :date_to,
    :date_end,
    :price,
    :currency_type,
    :discount_rate,
    :description,
    :created_at,
    :updated_at

  belongs_to :user
end
