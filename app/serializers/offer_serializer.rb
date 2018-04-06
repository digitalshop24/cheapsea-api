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
#  flight_type          :integer
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  price                :integer
#  currency_type        :integer
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

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
  belongs_to :airline

  has_many :transfers
end
