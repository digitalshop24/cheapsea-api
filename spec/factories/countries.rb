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

FactoryGirl.define do
  factory :country do
    iata "MyString"
    name "MyString"
    name_en "MyString"
  end
end
