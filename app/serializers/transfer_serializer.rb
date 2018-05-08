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

class TransferSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :airline, serializer: nil
  belongs_to :city, serializer: nil
end
