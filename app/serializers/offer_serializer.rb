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
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  from_airport_id                 :integer
#  to_airport_id                   :integer
#  name_auto                       :string
#  visits_count                    :integer          default(0), not null
#  images_countries_square_id      :integer
#  images_countries_rectangular_id :integer
#

class OfferSerializer
  include FastJsonapi::ObjectSerializer

  attributes :offer_type,
             :discount_type,
             :name,
             :name_auto,
             :airline_id,
             :is_direct,
             :transfers_count,
             :date_from,
             :date_to,
             :date_end,
             :price,
             :discount_rate,
             :description,
             :visits_count,
             :quality,
             :created_at,
             :updated_at,
             :statistic

  attribute :user do |object|
    UserSerializer.new(object.user).serializable_hash
  end

  attribute :airline do |object|
    AirlineSerializer.new(object.airline).serializable_hash
  end

  attribute :origin do |object|
    City::WithoutAirportsSerializer.new(object.origin).serializable_hash
  end

  attribute :destination do |object|
    City::WithoutAirportsSerializer.new(object.destination).serializable_hash
  end

  attribute :from_airport do |object|
    AirportSerializer.new(object.from_airport).serializable_hash
  end

  attribute :to_airport do |object|
    AirportSerializer.new(object.to_airport).serializable_hash
  end

  has_many :transfers
  has_many :tags
end
