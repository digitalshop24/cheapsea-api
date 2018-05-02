# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  iata         :string           not null
#  name         :string           not null
#  name_en      :string           not null
#  continent_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

describe Country, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name_en) }
end
