require "test_helper"

class QrtagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qrtag = qrtags(:one)
  end

  test "should get index" do
    get qrtags_url
    assert_response :success
  end

  test "should get new" do
    get new_qrtag_url
    assert_response :success
  end

  test "should create qrtag" do
    assert_difference("Qrtag.count") do
      post qrtags_url, params: { qrtag: { code: @qrtag.code } }
    end

    assert_redirected_to qrtag_url(Qrtag.last)
  end

  test "should show qrtag" do
    get qrtag_url(@qrtag)
    assert_response :success
  end

  test "should get edit" do
    get edit_qrtag_url(@qrtag)
    assert_response :success
  end

  test "should update qrtag" do
    patch qrtag_url(@qrtag), params: { qrtag: { code: @qrtag.code } }
    assert_redirected_to qrtag_url(@qrtag)
  end

  test "should destroy qrtag" do
    assert_difference("Qrtag.count", -1) do
      delete qrtag_url(@qrtag)
    end

    assert_redirected_to qrtags_url
  end
end
