# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  iata       :string           not null
#  name       :string           not null
#  active     :boolean          default(FALSE), not null
#  country_id :integer          not null
#  name_en    :string           not null
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe City, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name_en) }
  it { is_expected.to belong_to(:country) }
  it { is_expected.to belong_to(:origin) }
  it { is_expected.to belong_to(:destination) }
  it { is_expected.to belong_to(:from_airport) }
  it { is_expected.to belong_to(:to_airport) }
  it { is_expected.to have_many(:airports) }
end
