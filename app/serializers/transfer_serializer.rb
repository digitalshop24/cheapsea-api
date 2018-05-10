# == Schema Information
#
# Table name: transfers
#
#  id         :integer          not null, primary key
#  offer_id   :integer          not null
#  airline_id :integer
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#

class TransferSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :airline
  belongs_to :city
end
