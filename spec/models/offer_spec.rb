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
#  price                :integer
#  currency_type        :integer
#  discount_rate        :integer
#  description          :text
#  status               :integer          default("draft"), not null
#  user_id              :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  is_direct            :boolean          default(TRUE)
#

require 'rails_helper'

describe Offer, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:from_google_place_id) }
  it { is_expected.to validate_presence_of(:to_google_place_id) }
  it { is_expected.to validate_presence_of(:is_direct) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to have_many(:transfers) }
end
