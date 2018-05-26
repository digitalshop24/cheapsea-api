# == Schema Information
#
# Table name: offers
#
#  id                              :integer          not null, primary key
#  offer_type                      :integer
#  discount_type                   :integer
#  name                            :string
#  airline_id                      :integer
#  is_direct                       :boolean          default(TRUE)
#  transfers_count                 :integer
#  date_from                       :datetime
#  date_to                         :datetime
#  date_end                        :datetime
#  discount_rate                   :integer
#  description                     :text
#  status                          :integer          default("draft"), not null
#  user_id                         :integer
#  price                           :float
#  price_currency                  :string           default("RUB")
#  two_sides                       :boolean          default(FALSE), not null
#  flight_number                   :integer
#  gate                            :string
#  origin_id                       :integer
#  destination_id                  :integer
#  from_airport_id                 :integer
#  to_airport_id                   :integer
#  visits_count                    :integer          default(0), not null
#  name_auto                       :string
#  quality                         :integer          default("unknown"), not null
#  statistic                       :json             not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  images_countries_square_id      :integer
#  images_countries_rectangular_id :integer
#

FactoryGirl.define do
  factory :offer do
    offer_type 'airplane'
    discount_type 1
    name 'MyString'
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
    origin factory: :city
    destination factory: :city
  end
end
