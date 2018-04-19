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
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_direct            :boolean          default(TRUE)
#  price_cents          :integer          default(0), not null
#  price_currency       :string           default("USD"), not null
#

class Offer < ApplicationRecord
  CURRENCY_TYPES = %w(RUB USD EUR)

  enum status: { draft: 0, published: 1 }
  enum offer_type: { airplane: 0, trane: 1, bus: 2, car_rent: 3 }
  enum discount_type: { hot: 0, seasonal: 1, erroneous: 2, other: 3 }

  belongs_to :user
  belongs_to :airline, optional: true

  has_many :transfers, dependent: :destroy

  validates :name, :from_google_place_id, :to_google_place_id, presence: true
  validates :is_direct, presence: true, inclusion: { in: [ true, false ] }
  validates :two_sides, inclusion: { in: [ true, false ] }
  validates :price_currency, presence: true, inclusion: { in: CURRENCY_TYPES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
