require 'rails_helper'

describe Airport, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name_en) }
end