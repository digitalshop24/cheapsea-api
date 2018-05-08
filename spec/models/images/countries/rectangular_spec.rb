require 'rails_helper'

describe Images::Countries::Rectangular, type: :model do
  it { is_expected.to belong_to(:country) }
  it { is_expected.to have_many(:offers) }
end
