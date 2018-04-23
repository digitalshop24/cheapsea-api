require 'rails_helper'

describe City, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
end
