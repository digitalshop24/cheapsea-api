module RelationsPredicates
  include Dry::Logic::Predicates

  predicate(:airline_exists?) do |value|
    Airline.find_by(id: value).present?
  end

  predicate(:place_exists?) do |value|
    Geo::PlaceInfoService.call(place_id: value).result.present?
  end
end
