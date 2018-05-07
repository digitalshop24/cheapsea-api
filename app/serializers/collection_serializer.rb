class CollectionSerializer < ActiveModel::Serializer
  attributes :name, :name_en, :desc

  has_many :offers
end
