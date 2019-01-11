require 'test_helper'

class FamilyMedHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @family_med_history = family_med_histories(:one)
  end

  test "should get index" do
    get family_med_histories_url, as: :json
    assert_response :success
  end

  test "should create family_med_history" do
    assert_difference('FamilyMedHistory.count') do
      post family_med_histories_url, params: { family_med_history: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show family_med_history" do
    get family_med_history_url(@family_med_history), as: :json
    assert_response :success
  end

  test "should update family_med_history" do
    patch family_med_history_url(@family_med_history), params: { family_med_history: {  } }, as: :json
    assert_response 200
  end

  test "should destroy family_med_history" do
    assert_difference('FamilyMedHistory.count', -1) do
      delete family_med_history_url(@family_med_history), as: :json
    end

    assert_response 204
  end
end
