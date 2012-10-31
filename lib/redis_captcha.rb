require 'redis'
require 'redis_captcha/engine'
require 'redis_captcha/controller'
require 'generators/install_generator'

module RedisCaptcha

  autoload :Image, "redis_captcha/image"
  autoload :KeyHandler, "redis_captcha/key_handler"
  autoload :Model, "redis_captcha/model"

  mattr_accessor :redis_config
  @@redis_config = {
    :host => "127.0.0.1",
    :port => 6379,
    :db => 0
  }

  mattr_accessor :redis_scope
  @@redis_scope = "RedisCaptcha"

  mattr_accessor :expired_time
  @@expired_time = 1800

  mattr_accessor :locked_times
  @@locked_times = 30

  mattr_accessor :locked_time
  @@locked_time = 600

  mattr_accessor :image_magick_path
  @@image_magick_path = ""

  mattr_accessor :tempfile_path
  @@tempfile_path = "/tmp"

  mattr_accessor :tempfile_name
  @@tempfile_name = "redis_captcha"

  mattr_accessor :tempfile_type
  @@tempfile_type = ".png"

  mattr_accessor :content_type
  @@content_type = "image/png"

  mattr_accessor :width
  @@width = 120

  mattr_accessor :height
  @@height = 30

  mattr_accessor :chars
  @@chars = %w(2 3 4 5 6 7 9 a b c d e f g h j k m n p q r s t w x y z A C D E F G H J K L M N P Q R S T X Y Z)

  mattr_accessor :string_length
  @@string_length = {
    :max => 6,
    :min => 4
  }

  mattr_accessor :font_color
  @@font_color = "gray"

  mattr_accessor :background
  @@background = "white"

  mattr_accessor :line
  @@line = {
    :max => 4,
    :min => 2
  }

  mattr_accessor :line_color
  @@line_color = "gary"

  mattr_accessor :swirl_range
  @@swirl_range = {
    :max => 20,
    :min => -20
  }

  mattr_accessor :case_sensitive
  @@case_sensitive = false

  mattr_accessor :error_message
  @@error_message = "is invalid"

  def self.setup
    yield self
  end

  def self.redis
    @@redis ||= Redis.new(redis_config)
  end

  def self.options
    @@options ||= {
      :redis_scope => redis_scope,
      :expired_time => expired_time,
      :locked_times => locked_times,
      :locked_time => locked_time,
      :image_magick_path => image_magick_path,
      :tempfile_path => tempfile_path,
      :tempfile_name => tempfile_name,
      :tempfile_type => tempfile_type,
      :content_type => content_type,
      :width => width,
      :height => height,
      :chars => chars,
      :string_length => string_length,
      :font_color => font_color,
      :background => background,
      :line => line,
      :line_color => line_color,
      :swirl_range => swirl_range,
      :case_sensitive => case_sensitive,
      :error_message => error_message
    }
  end
end