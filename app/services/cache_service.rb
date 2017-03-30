class CacheService
  class << self
    def get(key)
      return nil if ENV['RAILS_ENV'] == 'test'
      JSON.parse($redis.get(key), "{}")
    end

    def set(key, v, expire_in = 12.hours)
      $redis.set(key, v)
      $redis.expire(key, expire_in)
    end
  end
end
