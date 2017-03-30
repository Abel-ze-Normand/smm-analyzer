class CacheService
  class << self
    def get(key)
      return nil if ENV['RAILS_ENV'] == 'test'
      v = $redis.get(key)
      if v
        JSON.parse(v)
      else
        nil
      end
    end

    def set(key, v, expire_in = 12.hours)
      $redis.set(key, v.to_json)
      $redis.expire(key, expire_in)
    end
  end
end
