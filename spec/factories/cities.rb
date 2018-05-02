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

FactoryGirl.define do
  factory :city do
    iata "MyString"
    name "MyString"
    name_en "MyString"
    country
  end
end
