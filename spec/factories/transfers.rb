# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  offer_id        :integer          not null
#  google_place_id :string
#  airline_id      :integer
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  city_id         :integer
#

FactoryGirl.define do
  factory :transfer do
    offer
    airline nil
    city
  end
end
