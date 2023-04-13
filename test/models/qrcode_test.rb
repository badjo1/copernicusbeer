require "test_helper"

class QrcodeTest < ActiveSupport::TestCase

   def test_to_reference
      assert_equal(1, Qrcode.to_reference('1'))
      assert_equal(9, Qrcode.to_reference('9'))
      assert_equal(10, Qrcode.to_reference('a'))
      assert_equal(24, Qrcode.to_reference('o'))
    end

end
