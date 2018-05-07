class CountrySerializer < ActiveModel::Serializer
  attributes :name

  belongs_to :continent
end
