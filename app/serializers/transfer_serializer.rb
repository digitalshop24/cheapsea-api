class TransferSerializer < ActiveModel::Serializer
  attributes :id, :airline, :google_place

  belongs_to :airline

  def google_place
    Geo::PlaceInfoService.call(place_id: object.google_place_id).result
  end
end
