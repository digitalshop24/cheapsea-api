# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :airline do
    name "MyString"
  end
end
