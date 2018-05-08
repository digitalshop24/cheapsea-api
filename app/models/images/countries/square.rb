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

class Images::Countries::Square < ApplicationRecord
  belongs_to :country

  has_many :offers, foreign_key: 'images_countries_square_id', dependent: :nullify

  mount_uploader :file, Country::RectangularUploader
end
