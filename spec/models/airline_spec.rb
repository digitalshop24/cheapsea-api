require 'rails_helper'

describe Airline, type: :model do
  it { is_expected.to have_many(:offers) }
  it { is_expected.to validate_presence_of(:name) }
end
