require 'test_helper'

class User::CurrentDiseasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_current_disease = user_current_diseases(:one)
  end

  test "should get index" do
    get user_current_diseases_url, as: :json
    assert_response :success
  end

  test "should create user_current_disease" do
    assert_difference('User::CurrentDisease.count') do
      post user_current_diseases_url, params: { user_current_disease: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_current_disease" do
    get user_current_disease_url(@user_current_disease), as: :json
    assert_response :success
  end

  test "should update user_current_disease" do
    patch user_current_disease_url(@user_current_disease), params: { user_current_disease: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_current_disease" do
    assert_difference('User::CurrentDisease.count', -1) do
      delete user_current_disease_url(@user_current_disease), as: :json
    end

    assert_response 204
  end
end
