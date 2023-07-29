require "test_helper"

class QrtagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qrtag = qrtags(:one)
    log_in_as(users(:one))
  end

  test "should get index" do
    get label_qrtags_url @qrtag.label, format: :csv
    assert_response :success
  end
  
end
