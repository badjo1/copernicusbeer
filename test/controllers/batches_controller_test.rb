require "test_helper"

class BatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batch = batches(:one)
    log_in_as(users(:one))
  end

  test "should get index" do
    get batches_url
    assert_response :success
  end

  test "should get new" do
    get new_batch_url
    assert_response :success
  end

  test "should create batch" do
    assert_difference("Batch.count") do
      post batches_url, params: { batch: { description: @batch.description, liters: @batch.liters, serialnumber: Batch.last.serialnumber+2 } }
    end

    assert_redirected_to batch_url(Batch.last)
  end

  test "should show batch" do
    get batch_url(@batch)
    assert_response :success
  end

  test "should get edit" do
    get edit_batch_url(@batch)
    assert_response :success
  end

  test "should update batch" do
    patch batch_url(@batch), params: { batch: { description: @batch.description, liters: @batch.liters, serialnumber: @batch.serialnumber } }
    assert_redirected_to batch_url(@batch)
  end

  # test "should destroy batch" do
  #   assert_difference("Batch.count", -1) do
  #     delete batch_url(@batch)
  #   end

  #   assert_redirected_to batches_url
  # end
end
