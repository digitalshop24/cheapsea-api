class Images::Countries::Square < ApplicationRecord
  belongs_to :country

  has_many :offers, foreign_key: 'images_countries_square_id', dependent: :nullify

  mount_uploader :file, Country::RectangularUploader
end
