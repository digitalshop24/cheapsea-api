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

FactoryGirl.define do
  factory :offer do
    offer_type 1
    discount_type 1
    name 'MyString'
    from_google_place_id 'ChIJOwg_06VPwokRYv534QaPC8g'
    to_google_place_id 'ChIJGzE9DS1l44kRoOhiASS_fHg'
    airline
    transfers_count 1
    date_from '2018-04-03 20:31:16'
    date_to '2018-04-03 20:31:16'
    date_end '2018-04-03 20:31:16'
    price 1
    discount_rate 1
    description 'MyText'
    user
    two_sides false
  end
end
