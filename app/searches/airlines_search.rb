class AirlinesSearch
  def initialize(params)
    @params = params
    @result = ::AirlinesIndex.limit(AirlinesIndex.load.count)
  end

  def call
    filter_by_query(params[:query])

    result
  end

  private

  attr_reader :params, :result

  def filter_by_query(query)
    return if query.nil?

    @result = result.query(match: { name: query })
  end
end
