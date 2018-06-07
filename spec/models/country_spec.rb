# == Schema Information
#
# Table name: countries
#
#  id                     :integer          not null, primary key
#  iata                   :string           not null
#  name                   :string           not null
#  name_en                :string           not null
#  desc                   :text
#  continent_id           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  police_phone_number    :string
#  ambulance_phone_number :string
#  inoculations           :boolean          default(FALSE), not null
#  snakes                 :boolean          default(FALSE), not null
#  thieves                :boolean          default(FALSE), not null
#  queer_money            :boolean          default(FALSE), not null
#

require 'rails_helper'

describe Country, type: :model do
  it { is_expected.to validate_presence_of(:iata) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:name_en) }
  it { is_expected.to belong_to(:continent) }
  it { is_expected.to have_many(:square_images) }
  it { is_expected.to have_many(:rectangular_images) }
end
