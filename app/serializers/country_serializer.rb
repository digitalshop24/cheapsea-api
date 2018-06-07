# == Schema Information
#
# Table name: countries
#
#  id                     :integer          not null, primary key
#  iata                   :string           not null
#  name                   :string           not null
#  name_en                :string           not null
#  desc                   :text
#  continent_id           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  police_phone_number    :string
#  ambulance_phone_number :string
#  inoculations           :boolean          default(FALSE), not null
#  snakes                 :boolean          default(FALSE), not null
#  thieves                :boolean          default(FALSE), not null
#  queer_money            :boolean          default(FALSE), not null
#

class CountrySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name,
    :name_en,
    :desc,
    :police_phone_number,
    :ambulance_phone_number,
    :inoculations,
    :snakes,
    :thieves,
    :queer_money
end
