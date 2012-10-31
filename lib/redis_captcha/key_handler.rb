module RedisCaptcha
  class KeyHandler
    def initialize(captcha_key)
      @redis = RedisCaptcha.redis
      @captcha_key = captcha_key
      @options = RedisCaptcha.options

      @string_key = "#{@options[:redis_scope]}:#{@captcha_key}:string"
      @locked_times_key = "#{@options[:redis_scope]}:#{@captcha_key}:locked_times"
    end

    def set(string)
      string = @options[:case_sensitive] ? string : string.downcase

      @redis.set(@string_key, string)
      @redis.expire(@string_key, @options[:expired_time])

      locked_times = @redis.get(@locked_times_key).to_i
      @redis.incrby(@locked_times_key, 1)
      @redis.expire(@locked_times_key, @options[:locked_time]) if locked_times == 0
    end

    def delete
      @redis.del(@string_key)
      #@redis.del(@locked_times_key)
    end

    def locked?
      locked_times = @redis.get(@locked_times_key).to_i
      @captcha_key.blank? || (locked_times >= @options[:locked_times])
    end

    def valid?(captcha)
      string = @redis.get(@string_key)
      if captcha.blank? || string.blank?
        return false
      else
        string == (@options[:case_sensitive] ? captcha : captcha.downcase)
      end
    end
  end
end