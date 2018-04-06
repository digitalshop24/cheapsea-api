# == Schema Information
#
# Table name: offers
#
#  id                   :integer          not null, primary key
#  offer_type           :integer
#  discount_type        :integer
#  name                 :string
#  from_google_place_id :integer
#  to_google_place_id   :integer
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

class Offer < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  enum offer_type: { airplane: 0, trane: 1, bus: 2, car_rent: 3 }
  enum discount_type: { hot: 0, seasonal: 1, erroneous: 2, other: 3 }
  enum flight_type: { direct: 0, transfer: 1 }
  enum currency_type: { RUB: 0, USD: 1, EUR: 2 }

  belongs_to :user
  belongs_to :airline, optional: true

  validates :name, :from_google_place_id, :to_google_place_id, presence: true

  scope :published, -> { where(status: 'published') }
end
