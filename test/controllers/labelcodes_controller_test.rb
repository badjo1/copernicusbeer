require "test_helper"

class LabelcodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @labelcode = labelcodes(:one)
  end

  test "should get index" do
    get labelcodes_url
    assert_response :success
  end

  test "should get new" do
    get new_labelcode_url
    assert_response :success
  end

  test "should create labelcode" do
    assert_difference("Labelcode.count") do
      post labelcodes_url, params: { labelcode: { baseurl: @labelcode.baseurl, code: @labelcode.code } }
    end

    assert_redirected_to labelcode_url(Labelcode.last)
  end

  test "should show labelcode" do
    get labelcode_url(@labelcode)
    assert_response :success
  end

  test "should get edit" do
    get edit_labelcode_url(@labelcode)
    assert_response :success
  end

  test "should update labelcode" do
    patch labelcode_url(@labelcode), params: { labelcode: { baseurl: @labelcode.baseurl, code: @labelcode.code } }
    assert_redirected_to labelcode_url(@labelcode)
  end

  test "should destroy labelcode" do
    assert_difference("Labelcode.count", -1) do
      delete labelcode_url(@labelcode)
    end

    assert_redirected_to labelcodes_url
  end
end
