class Country < ApplicationRecord
  validates :iata, :name, :name_en, presence: true
end
