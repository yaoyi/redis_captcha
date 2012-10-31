RedisCaptcha.setup do |config|

  # ==> Redis configuration
  config.redis_config = {
    :host => "127.0.0.1",
    :port => 6379,
    :db => 0
  }

  # ==> Redis scope configuration
  config.redis_scope = "RedisCaptcha"

  # ==> Redis key expired time
  config.expired_time = 1800

  # ==> Redis locked times and locked time
  config.locked_times = 30
  config.locked_time = 600

  # ==> ImageMagick path
  config.image_magick_path = ""

  # ==> Tempfile path
  config.tempfile_path = "/tmp"

  # ==> Tempfile name
  config.tempfile_name = "redis_captcha"

  # ==> Tempfile type and content type
  config.tempfile_type = ".png"
  config.content_type = "image/png"

  # ==> Image width and height
  config.width = 120
  config.height = 30

  # ==> Char set
  # You can add/remove char you want
  config.chars = %w(2 3 4 5 6 7 9 a c d e f g h j k m n p q r s t w x y z A C D E F G H J K L M N P Q R S T X Y Z)

  # ==> String length
  # You can set the same value if you don't want it to be random length
  config.string_length = {
    :max => 6,
    :min => 4
  }

  # ==> Image font color and background
  config.font_color = "gray"
  config.background = "white"

  # ==> Lines on your captcha
  # You can set 0, 0 if you don't want to draw any line on your captcha
  config.line = {
    :max => 4,
    :min => 2
  }
  config.line_color = "gary"

  # ==> Swirl
  # http://www.imagemagick.org/Usage/warping/#swirl
  config.swirl_range = {
    :max => 20,
    :min => -20
  }

  # ==> Case sensitive
  config.case_sensitive = false

  # ==> Error message
  # if you want to use I18n in your model, you can set it to be nil
  config.error_message = "is invalid"
end