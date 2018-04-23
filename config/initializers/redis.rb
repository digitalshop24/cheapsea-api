module ReadCache
  def self.redis
    redis = Redis.new(
      url: ENV['REDIS_URL'],
      timeout: 500
    )
    redis.flushdb if Rails.env.test?

    @redis_namespace ||= Redis::Namespace.new(:cheapsea, redis: redis)
  end
end
