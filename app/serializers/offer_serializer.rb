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
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  origin_id            :integer
#  destination_id       :integer
#

class OfferSerializer < ActiveModel::Serializer
  attributes :id,
    :offer_type,
    :discount_type,
    :name,
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
    :created_at,
    :updated_at

  belongs_to :user
  belongs_to :airline

  has_many :transfers
end
