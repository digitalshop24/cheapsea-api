# == Schema Information
#
# Table name: transfers
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  airline_id :integer
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#

require 'rails_helper'

describe Transfer, type: :model do
  it { is_expected.to belong_to(:offer) }
  it { is_expected.to belong_to(:airline) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to validate_presence_of(:city_id) }
end
