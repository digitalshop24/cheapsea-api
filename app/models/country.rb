# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  iata         :string           not null
#  name         :string           not null
#  name_en      :string           not null
#  continent_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Country < ApplicationRecord
  validates :iata, :name, :name_en, presence: true

  belongs_to :continent, optional: true
end
