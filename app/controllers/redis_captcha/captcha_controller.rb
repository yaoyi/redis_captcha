module RedisCaptcha
  class CaptchaController < ApplicationController
    def show
      captcha = RedisCaptcha::Image.new(session[:captcha_key])
      tempfile = captcha.generate
      if tempfile
        send_file(tempfile, :type => captcha.content_type, :disposition => 'inline', :filename => captcha.filename)
      else
        render :nothing => true
      end
    end
  end
end