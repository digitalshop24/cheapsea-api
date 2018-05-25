class AirportsSearch
  def initialize(params)
    @params = params
    @result = ::AirportsIndex.limit(AirportsIndex.load.count)
  end

  def call
    filter_by_query(params[:query])

    result
  end

  private

  attr_reader :params, :result

  def filter_by_query(query)
    return if query.nil?

    @result = result.query(multi_match: { query: query, fields: %w[name name_en] })
  end
end
