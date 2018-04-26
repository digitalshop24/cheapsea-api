# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  iata       :string           not null
#  name       :string           not null
#  active     :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :city do
    iata "MyString"
    name "MyString"
  end
end
