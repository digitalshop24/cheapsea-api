class Filters::CitiesFilter < Filtering::Base
  def initialize(params)
    super(params)
  end

  private

  # Required methods

  def relation
    City.includes(:airports)
  end

  def complex_acessible_params
    %i[query]
  end

  # Complex filters

  def filter_by_query(query)
    result.where('name ILIKE ? or name_en ILIKE ?', "%#{query}%", "%#{query}%")
  end
end
