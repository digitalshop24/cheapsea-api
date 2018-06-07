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

FactoryGirl.define do
  factory :transfer do
    offer
    airline nil
    city
  end
end
