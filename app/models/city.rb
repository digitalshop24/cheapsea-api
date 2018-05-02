# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  iata       :string           not null
#  name       :string           not null
#  active     :boolean          default(FALSE), not null
#  country_id :integer          not null
#  name_en    :string           not null
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  validates :iata, :name, :name_en, presence: true

  belongs_to :country

  has_many :airports

  scope :active, -> { where(active: true) }
end
