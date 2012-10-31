Rails.application.routes.draw do

  mount RedisCaptcha::Engine => "/redis_captcha"
end
