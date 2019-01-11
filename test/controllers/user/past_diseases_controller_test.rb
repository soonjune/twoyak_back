require 'test_helper'

class User::PastDiseasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_past_disease = user_past_diseases(:one)
  end

  test "should get index" do
    get user_past_diseases_url, as: :json
    assert_response :success
  end

  test "should create user_past_disease" do
    assert_difference('User::PastDisease.count') do
      post user_past_diseases_url, params: { user_past_disease: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_past_disease" do
    get user_past_disease_url(@user_past_disease), as: :json
    assert_response :success
  end

  test "should update user_past_disease" do
    patch user_past_disease_url(@user_past_disease), params: { user_past_disease: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_past_disease" do
    assert_difference('User::PastDisease.count', -1) do
      delete user_past_disease_url(@user_past_disease), as: :json
    end

    assert_response 204
  end
end
