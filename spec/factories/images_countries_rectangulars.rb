# == Schema Information
#
# Table name: images_countries_rectangulars
#
#  id         :integer          not null, primary key
#  country_id :integer
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :images_countries_rectangular, class: 'Images::Countries::Rectangular' do
    country nil
  end
end
