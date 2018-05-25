class OffersSearch
  def initialize(params)
    @params = params
  end

  def call
    result = [
      filter_by_directions
    ].reduce(&:&)

    result
  end

  private

  attr_reader :params

  def index
    OffersIndex.limit(OffersIndex.load.count)
  end

  def filter_by_directions
    origins = [filter_by_origin_countries_ids, filter_by_origin_cities_ids].flatten.compact
    destinations = [filter_by_destination_countries_ids, filter_by_destination_cities_ids].flatten.compact

    return origins.uniq if destinations.empty? && params[:destination].nil?
    return destinations.uniq if origins.empty? && params[:origin].nil?

    origins & destinations
  end

  def filter_by_origin_countries_ids
    countries_ids = params.dig('origin', 'countries')&.split(',')
    return if countries_ids.nil?
    index.filter(terms: { origin_country_id: countries_ids }).load.map(&:id)
  end

  def filter_by_origin_cities_ids
    cities_ids = params.dig('origin', 'cities')&.split(',')
    return if cities_ids.nil?
    index.filter(terms: { origin_city_id: cities_ids }).load.map(&:id)
  end

  def filter_by_destination_countries_ids
    countries_ids = params.dig('destination', 'countries')&.split(',')
    return if countries_ids.nil?
    index.filter(terms: { destination_country_id: countries_ids }).load.map(&:id)
  end

  def filter_by_destination_cities_ids
    cities_ids = params.dig('destination', 'cities')&.split(',')
    return if cities_ids.nil?
    index.filter(terms: { destination_city_id: cities_ids }).load.map(&:id)
  end
end
