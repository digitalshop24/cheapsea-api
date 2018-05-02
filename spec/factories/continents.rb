# == Schema Information
#
# Table name: continents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :continent do
    name "MyString"
  end
end
