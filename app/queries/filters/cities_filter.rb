class Filters::CitiesFilter
  def initialize(query)
    @query = query
    @relation = City.includes(:airports)
  end

  def call
    return popular_cities if query.nil?

    result = relation.where('name ILIKE ? or name_en ILIKE ?', "%#{query}%", "%#{query}%")

    if result.empty?
      result = result.to_a << { google_places: ThirdParty::Geo::AutocompleteService.call(input: query).result }
    end

    result
  end

  private

  attr_reader :query, :relation

  def popular_cities
    relation.active.includes(:airports)
  end
end
