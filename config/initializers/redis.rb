module ReadCache
  def self.redis
    @redis ||= Redis.new(
      url: ENV['REDIS_URL'],
      timeout: 500
    )
  end
end
