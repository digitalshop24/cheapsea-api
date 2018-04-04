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

FactoryGirl.define do
  factory :offer do
    offer_type 1
    discount_type 1
    name "MyString"
    from_google_place_id 1
    to_google_place_id 1
    airline_id 1
    flight_type 1
    transfers_count 1
    date_from "2018-04-03 20:31:16"
    date_to "2018-04-03 20:31:16"
    date_end "2018-04-03 20:31:16"
    price 1
    discount_rate 1
    description "MyText"
    user
  end
end
