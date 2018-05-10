class City::WithoutAirportsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
end
