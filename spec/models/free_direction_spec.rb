require 'rails_helper'

describe FreeDirection, type: :model do
  it { is_expected.to validate_presence_of(:origin_id) }
  it { is_expected.to validate_presence_of(:destination_id) }
  it { is_expected.to belong_to(:destination) }
  it { is_expected.to belong_to(:origin) }
end
