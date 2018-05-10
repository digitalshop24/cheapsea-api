class AirportSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :name_en, :iata
end
