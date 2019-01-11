require 'test_helper'

class User::CurrentSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_current_supplement = user_current_supplements(:one)
  end

  test "should get index" do
    get user_current_supplements_url, as: :json
    assert_response :success
  end

  test "should create user_current_supplement" do
    assert_difference('User::CurrentSupplement.count') do
      post user_current_supplements_url, params: { user_current_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_current_supplement" do
    get user_current_supplement_url(@user_current_supplement), as: :json
    assert_response :success
  end

  test "should update user_current_supplement" do
    patch user_current_supplement_url(@user_current_supplement), params: { user_current_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_current_supplement" do
    assert_difference('User::CurrentSupplement.count', -1) do
      delete user_current_supplement_url(@user_current_supplement), as: :json
    end

    assert_response 204
  end
end
