# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  iata       :string           not null
#  name       :string           not null
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe City, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
end
