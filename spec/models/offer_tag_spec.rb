# == Schema Information
#
# Table name: offer_tags
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  tag_id     :integer          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe OfferTag, type: :model do
  it { is_expected.to validate_presence_of(:tag_id) }
  it { is_expected.to belong_to(:offer) }
  it { is_expected.to belong_to(:tag) }
end
