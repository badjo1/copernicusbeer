require "test_helper"

class QrtagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qrtag = qrtags(:one)
  end

  test "should get index" do
    get label_qrtags_url @qrtag.label, format: :csv
    assert_response :success
  end

  test "should show qrtag" do
    get qrtag_url qr: 'q1', label: @qrtag.label.code, tag: @qrtag.code
    assert_response :success
  end

end
