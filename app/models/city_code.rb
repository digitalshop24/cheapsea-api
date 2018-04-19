class CityCode < ApplicationRecord
  validates :iata, :name, presence: true
end
