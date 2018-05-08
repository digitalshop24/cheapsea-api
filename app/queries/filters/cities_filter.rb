class Filters::CitiesFilter
  def initialize(query)
    @query = query
    @relation = City.includes(:airports)
  end

  def call
    return popular_cities if query.nil?

    relation.where('name ILIKE ? or name_en ILIKE ?', "%#{query}%", "%#{query}%")
  end

  private

  attr_reader :query, :relation

  def popular_cities
    relation.active.includes(:airports)
  end
end
