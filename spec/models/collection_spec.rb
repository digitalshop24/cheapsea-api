require 'rails_helper'

describe Collection, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:offer_collections) }
  it { is_expected.to have_many(:offers) }
end
