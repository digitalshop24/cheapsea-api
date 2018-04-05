class Airlines::GetAllService
  def call
    @result ||= read_from_cache
    if @result.nil?
      response = HTTParty.get('http://api.travelpayouts.com/data/airlines.json')

      @result ||= JSON.parse(response.body)

      add_to_cache(@result)
    end

    @result.is_a?(String) ? eval(@result) : @result
  end

  private

  def read_from_cache
    ReadCache.redis.get('airlines')
  end

  def add_to_cache(result)
    ReadCache.redis.set('airlines', result)
  end
end
