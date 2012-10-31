module RedisCaptcha
  class Image
    def initialize(captcha_key)
      @key_handler = RedisCaptcha::KeyHandler.new(captcha_key)
      @options = RedisCaptcha.options
    end

    def generate
      unless @key_handler.locked?
        @string = get_string
        @key_handler.set(@string)

        tempfile = Tempfile.new([@options[:tempfile_name], @options[:tempfile_type]], @options[:tempfile_path])

        params = ""
        params << get_line_param
        params << get_image_size_param
        params << get_background_param
        params << get_string_param
        params << get_swirl_param

        command = `#{@options[:image_magick_path]}convert #{params} #{tempfile.path}`
        puts "#{@options[:image_magick_path]}convert #{params} #{tempfile.path}"

        tempfile
      else
        nil
      end
    end

    def filename
      "#{@options[:tempfile_name]}#{@options[:tempfile_type]}"
    end

    def content_type
      @options[:content_type]
    end

    protected

    def get_string
      chars = @options[:chars]
      max = @options[:string_length][:max]
      min = @options[:string_length][:min]
      range = max - min
      length = ((range > 0) ? rand(range + 1) : 0) + min

      string = ""
      length.times { string << chars[rand(chars.length)] }

      string
    end

    def get_line_param
      max = @options[:line][:max]
      min = @options[:line][:min]
      range = max - min
      amount = ((range > 0) ? rand(range + 1) : 0) + min

      params = ""

      amount.times do
        params << "-fill #{@options[:line_color]} "
        params << "-draw \"line #{rand(10)},#{rand(@options[:height])} #{rand(10) + @options[:width] - 10},#{rand(@options[:height])}\" "
      end

      params
    end

    def get_image_size_param
      "-size #{@options[:width]}X#{@options[:height]} "
    end

    def get_background_param
      "-background #{@options[:background]} "
    end

    def get_string_param
      "-gravity center -fill #{@options[:font_color]} label:\"#{@string}\" "
    end

    def get_swirl_param
      max = @options[:swirl_range][:max]
      min = @options[:swirl_range][:min]

      "-swirl #{rand(min..max)} "
    end

    def get_charcoal
      rand(3)
    end
  end
end