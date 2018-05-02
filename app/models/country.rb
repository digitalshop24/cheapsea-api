class Country < ApplicationRecord
  validates :iata, :name, :name_en, presence: true

  belongs_to :continent, optional: true
end
