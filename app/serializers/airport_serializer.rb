# == Schema Information
#
# Table name: airports
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  name_en    :string           not null
#  city_id    :integer          not null
#  iata       :string           not null
#  flightable :boolean          default(FALSE), not null
#  latitude   :float
#  longitude  :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AirportSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :name_en, :iata
end
