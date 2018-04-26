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
#  is_direct            :boolean          default(TRUE)
#  transfers_count      :integer
#  date_from            :datetime
#  date_to              :datetime
#  date_end             :datetime
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  price                :float
#  price_currency       :string           default("RUB")
#  two_sides            :boolean          default(FALSE), not null
#  flight_number        :integer
#  gate                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  origin_id            :integer
#  destination_id       :integer
#

require 'rails_helper'

describe Offer, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:is_direct) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:price_currency) }
  it { is_expected.to validate_presence_of(:origin_id) }
  it { is_expected.to validate_presence_of(:destination_id) }
  it { is_expected.to validate_presence_of(:from_google_place_id) }
  it { is_expected.to validate_presence_of(:to_google_place_id) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to have_many(:transfers) }
end
