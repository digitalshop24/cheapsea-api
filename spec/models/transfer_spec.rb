# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  offer_id        :integer          not null
#  google_place_id :string
#  airline_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

describe Transfer, type: :model do
  it { is_expected.to belong_to(:offer) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:offer_id) }
end
