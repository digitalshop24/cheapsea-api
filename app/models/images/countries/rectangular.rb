class Images::Countries::Rectangular < ApplicationRecord
  belongs_to :country

  has_many :offers, foreign_key: 'images_countries_rectangular_id', dependent: :nullify

  mount_uploader :file, Country::SquareUploader
end
