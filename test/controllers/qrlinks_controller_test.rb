require "test_helper"

class QrlinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @qrlink = qrlinks(:one)
    @label  = @qrlink.label
    log_in_as(users(:one))

  end

  test "should get index" do
    get qrlinks_url
    assert_response :success
  end

  test "should get new" do
    get new_label_qrlink_url @label
    assert_response :success
  end

  test "should create qrlink" do
    assert_difference("Qrlink.count") do
      post label_qrlinks_url(@label), params: { qrlink: { label_id: @qrlink.label_id, qrcode_id: @qrlink.qrcode_id, url: @qrlink.url } }
    end

    assert_redirected_to label_url(@label)
  end


  test "should show qrlink" do
    get qrlink_url(@qrlink)
    assert_response :success
  end

  test "should get edit" do
    get edit_qrlink_url(@qrlink)
    assert_response :success
  end

  test "should update qrlink" do
    patch qrlink_url(@qrlink), params: { qrlink: { url: @qrlink.url } }
    assert_redirected_to qrlink_url(@qrlink)
  end

  # test "should destroy qrlink" do
  #   assert_difference("Qrlink.count", -1) do
  #     delete qrlink_url(@qrlink)
  #   end

  #   assert_redirected_to qrlinks_url
  # end
end
