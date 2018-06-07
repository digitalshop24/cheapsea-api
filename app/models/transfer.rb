# == Schema Information
#
# Table name: transfers
#
#  id            :integer          not null, primary key
#  offer_id      :integer          not null
#  airline_id    :integer
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  city_id       :integer
#  to_airline_id :integer
#  airport_id    :integer
#  to_airport_id :integer
#  to_city_id    :integer
#  type          :integer          default("from_origin")
#

class Transfer < ApplicationRecord
  self.inheritance_column = nil

  enum type: { from_origin: 0, to_origin: 1 }

  belongs_to :offer, counter_cache: true
  belongs_to :user
  belongs_to :airline
  belongs_to :city
  belongs_to :airport
  belongs_to :to_airline, class_name: 'Airline', foreign_key: 'to_airline_id'
  belongs_to :to_city, class_name: 'City', foreign_key: 'to_city_id'
  belongs_to :to_airport, class_name: 'Airport', foreign_key: 'to_airport_id'

  validates :city_id, :airline_id, :airport_id, :to_city_id, :to_airline_id, :to_airport_id, presence: true

  validates :type, inclusion: { in: %w[from_origin to_origin] }, allow_blank: true
  validates :number, uniqueness: { scope: %i[type offer_id] }

  before_save do
    set_type_if_one_side
  end

  private

  def set_type_if_one_side
    self.type = :from_origin unless offer.two_sides
  end
end
