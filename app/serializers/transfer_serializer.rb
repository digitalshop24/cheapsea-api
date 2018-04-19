# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  offer_id        :integer          not null
#  google_place_id :string
#  airline_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class TransferSerializer < ActiveModel::Serializer
  attributes :id, :airline, :google_place

  belongs_to :airline

  def google_place
    ThirdParty::Geo::PlaceInfoService.call(place_id: object.google_place_id).result
  end
end
