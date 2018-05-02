# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  name_en    :string           not null
#  city_id    :integer          not null
#  iata       :string           not null
#  flightable :boolean          default(FALSE), not null
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Airport, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name_en) }
end
