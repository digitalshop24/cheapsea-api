class City::WithoutAirportsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  attribute :country do |object|
    CountrySerializer.new(object.country).serializable_hash
  end
end
