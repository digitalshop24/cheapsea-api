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
#  desc         :text
#

class Country < ApplicationRecord
  validates :iata, :name, :name_en, presence: true

  belongs_to :continent, optional: true

  has_many :square_images, class_name: 'Images::Countries::Square'
  has_many :rectangular_images, class_name: 'Images::Countries::Rectangular'

  accepts_nested_attributes_for :square_images, allow_destroy: true
  accepts_nested_attributes_for :rectangular_images, allow_destroy: true
end
