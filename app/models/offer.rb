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
  enum status: %i(draft published)
  enum offer_type: %i(airplane trane bus car_rent)
  enum discount_type: %i(hot seasonal erroneous other)
  enum flight_type: %i(direct transfer)
  enum currency_type: %i(RUB USD EUR)

  belongs_to :user

  validates :name, :from_google_place_id, :to_google_place_id, presence: true

  scope :published, -> { where(status: 'published') }
end
