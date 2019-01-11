require 'test_helper'

class User::FamilyMedHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_family_med_history = user_family_med_histories(:one)
  end

  test "should get index" do
    get user_family_med_histories_url, as: :json
    assert_response :success
  end

  test "should create user_family_med_history" do
    assert_difference('User::FamilyMedHistory.count') do
      post user_family_med_histories_url, params: { user_family_med_history: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_family_med_history" do
    get user_family_med_history_url(@user_family_med_history), as: :json
    assert_response :success
  end

  test "should update user_family_med_history" do
    patch user_family_med_history_url(@user_family_med_history), params: { user_family_med_history: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_family_med_history" do
    assert_difference('User::FamilyMedHistory.count', -1) do
      delete user_family_med_history_url(@user_family_med_history), as: :json
    end

    assert_response 204
  end
end
