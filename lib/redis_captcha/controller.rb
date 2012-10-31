require 'uuid'

module RedisCaptcha
  module Controller
    def generate_captcha_key
      if session[:captcha_key].blank?
        uuid = UUID.new
        session[:captcha_key] = uuid.generate.gsub("-", "").hex
      end
    end
  end
end

ActionController::Base.send :include, RedisCaptcha::Controller