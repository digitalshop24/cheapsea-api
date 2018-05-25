# == Schema Information
#
# Table name: airlines
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  iata       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Airline < ApplicationRecord
  has_many :offers

  validates :name, presence: true

  update_index('airlines#airline') { self }
end
