require 'test_helper'

class User::PastSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_past_supplement = user_past_supplements(:one)
  end

  test "should get index" do
    get user_past_supplements_url, as: :json
    assert_response :success
  end

  test "should create user_past_supplement" do
    assert_difference('User::PastSupplement.count') do
      post user_past_supplements_url, params: { user_past_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_past_supplement" do
    get user_past_supplement_url(@user_past_supplement), as: :json
    assert_response :success
  end

  test "should update user_past_supplement" do
    patch user_past_supplement_url(@user_past_supplement), params: { user_past_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_past_supplement" do
    assert_difference('User::PastSupplement.count', -1) do
      delete user_past_supplement_url(@user_past_supplement), as: :json
    end

    assert_response 204
  end
end
