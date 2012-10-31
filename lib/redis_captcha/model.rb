module RedisCaptcha
  module Model
    extend ActiveSupport::Concern

    def self.included(base)
      base.extend(ClassMethods)
      base.send :validate, :check_captcha
      base.send :after_save, :delete_captcha
      base.send :attr_accessor, :captcha, :captcha_key
    end

    module ClassMethods
    end

    def key_handler
      @key_handler ||= RedisCaptcha::KeyHandler.new(captcha_key)
    end

    def check_captcha
      if without_captcha?
        @skip_captcha = false
      else
        errors.add(:captcha, RedisCaptcha::options[:error_message]) unless key_handler.valid?(captcha)
      end
    end

    def delete_captcha
      key_handler.delete
    end

    def without_captcha?
      !!@skip_captcha
    end

    def valid_without_captcha?
      @skip_captcha = true
      self.valid?
    end

    def save_without_captcha
      @skip_captcha = true
      self.save
    end
  end
end