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

FactoryGirl.define do
  factory :images_countries_square, class: 'Images::Countries::Square' do
    country nil
    file "MyString"
  end
end
