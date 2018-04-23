class City < ApplicationRecord
  validates :iata, :name, presence: true

  scope :active, -> { where(active: true) }
end
