# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  offer_id        :integer          not null
#  google_place_id :string
#  airline_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :transfer do
    offer
    google_place_id 'ChIJOwg_06VPwokRYv534QaPC8g'
    airline nil
  end
end
