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

require 'rails_helper'

describe Transfer, type: :model do
  it { is_expected.to belong_to(:offer) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:airport) }
  it { is_expected.to belong_to(:to_airport) }
  it { is_expected.to belong_to(:to_airline) }
  it { is_expected.to belong_to(:to_city) }
  it { is_expected.to validate_presence_of(:city_id) }
  it { is_expected.to validate_presence_of(:airport_id) }
  it { is_expected.to validate_presence_of(:airline_id) }
  it { is_expected.to validate_presence_of(:city_id) }
  it { is_expected.to validate_presence_of(:to_airport_id) }
  it { is_expected.to validate_presence_of(:to_city_id) }
  it { is_expected.to validate_presence_of(:to_airline_id) }
end
