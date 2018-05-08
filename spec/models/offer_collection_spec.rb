# == Schema Information
#
# Table name: offer_collections
#
#  id            :integer          not null, primary key
#  offer_id      :integer          not null
#  collection_id :integer          not null
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

describe OfferCollection, type: :model do
  it { is_expected.to validate_presence_of(:offer_id) }
  it { is_expected.to validate_presence_of(:collection_id) }
  it { is_expected.to belong_to(:offer) }
end
