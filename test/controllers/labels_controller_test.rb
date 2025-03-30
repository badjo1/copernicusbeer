require "test_helper"

class LabelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @label = labels(:one)
    @batch = @label.batch
    log_in_as(users(:one))
  end

  test "should get new" do
    get new_batch_label_url @batch
    assert_response :success
  end

  test "should create label" do
    assert_difference("Label.count") do
      post batch_labels_url(@batch), params: { label: { code: "unq", description: @label.description, number_of_labels: @label.number_of_labels} }
    end

    assert_redirected_to label_url(Label.last)
  end

  test "should show label" do
    get label_url(@label)
    assert_response :success
  end

  test "should get edit" do
    get edit_label_url(@label)
    assert_response :success
  end

  test "should update label" do
    patch label_url(@label), params: { label: { code: @label.code } }
    assert_redirected_to label_url(@label)
  end

  test "should destroy label" do
    assert_difference("Label.count", -1) do
      delete label_url(@label)
    end

    assert_redirected_to batch_url (@batch)
  end

end
