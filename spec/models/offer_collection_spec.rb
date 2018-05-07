require 'rails_helper'

describe OfferCollection, type: :model do
  it { is_expected.to validate_presence_of(:offer_id) }
  it { is_expected.to validate_presence_of(:collection_id) }
  it { is_expected.to belong_to(:offer) }
end
