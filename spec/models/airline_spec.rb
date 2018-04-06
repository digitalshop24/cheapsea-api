# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Airline, type: :model do
  it { is_expected.to have_many(:offers) }
  it { is_expected.to validate_presence_of(:name) }
end
