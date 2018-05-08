# == Schema Information
#
# Table name: images_countries_squares
#
#  id         :integer          not null, primary key
#  country_id :integer
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Images::Countries::Square, type: :model do
  it { is_expected.to belong_to(:country) }
  it { is_expected.to have_many(:offers) }
end
