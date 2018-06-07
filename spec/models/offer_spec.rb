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
#  main                            :boolean          default(FALSE), not null
#

require 'rails_helper'

describe Offer, type: :model do
  it { is_expected.to validate_presence_of(:is_direct) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:price_currency) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to belong_to(:images_countries_square) }
  it { is_expected.to belong_to(:images_countries_rectangular) }
  it { is_expected.to belong_to(:from_airport) }
  it { is_expected.to belong_to(:origin) }
  it { is_expected.to belong_to(:destination) }
  it { is_expected.to belong_to(:to_airport) }
  it { is_expected.to have_many(:transfers) }
  it { is_expected.to have_many(:offer_tags) }
  it { is_expected.to have_many(:tags) }
  it { is_expected.to have_many(:offer_collections) }
  it { is_expected.to have_many(:collections) }
end
