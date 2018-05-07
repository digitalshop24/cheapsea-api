# == Schema Information
#
# Table name: offers
#
#  id                   :integer          not null, primary key
#  offer_type           :integer
#  discount_type        :integer
#  name                 :string
#  from_google_place_id :string
#  to_google_place_id   :string
#  airline_id           :integer
#  is_direct            :boolean          default(TRUE)
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  price                :float
#  price_currency       :string           default("RUB")
#  two_sides            :boolean          default(FALSE), not null
#  flight_number        :integer
#  gate                 :string
#  origin_id            :integer
#  destination_id       :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  from_airport_id      :integer
#  to_airport_id        :integer
#

class OfferSerializer < ActiveModel::Serializer
  attributes :id,
    :offer_type,
    :discount_type,
    :name,
    :name_auto,
    :from_google_place_id,
    :to_google_place_id,
    :airline_id,
    :is_direct,
    :transfers_count,
    :date_from,
    :date_to,
    :date_end,
    :price,
    :discount_rate,
    :description,
    :visits_count,
    :created_at,
    :updated_at

  belongs_to :user
  belongs_to :airline
  belongs_to :origin, serializer_options: { no_airports: true }
  belongs_to :destination
  belongs_to :from_airport
  belongs_to :to_airport

  has_many :transfers

  class CitySerializer < ActiveModel::Serializer
    attributes :name

    belongs_to :country
  end
end
