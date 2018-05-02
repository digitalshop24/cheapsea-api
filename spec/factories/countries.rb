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

FactoryGirl.define do
  factory :country do
    iata "MyString"
    name "MyString"
    name_en "MyString"
  end
end
