require 'test_helper'

class RedisCaptchaTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, RedisCaptcha
  end
end
