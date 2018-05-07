# == Schema Information
#
# Table name: continents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Continent, type: :model do
  it { is_expected.to validate_presence_of(:name) }
end
