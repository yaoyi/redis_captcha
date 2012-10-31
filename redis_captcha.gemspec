$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "redis_captcha/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "redis_captcha"
  s.version     = RedisCaptcha::VERSION
  s.authors     = ["hellolucky"]
  s.email       = ["hellolucky123@gmail.com"]
  s.homepage    = "http://blog.hellolucky.info"
  s.summary     = "RedisCaptcha is a captcha engine base on Redis for Rails 3.2."
  s.description = "RedisCaptcha provides simple captcha that can be read by human."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "redis"
  s.add_dependency "uuid"
end
