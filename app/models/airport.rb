class Airport < ApplicationRecord
  validates :name, :name_en, :iata, presence: true

  belongs_to :city
end
