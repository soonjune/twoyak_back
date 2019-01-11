require 'test_helper'

class User::WatchSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_watch_supplement = user_watch_supplements(:one)
  end

  test "should get index" do
    get user_watch_supplements_url, as: :json
    assert_response :success
  end

  test "should create user_watch_supplement" do
    assert_difference('User::WatchSupplement.count') do
      post user_watch_supplements_url, params: { user_watch_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_watch_supplement" do
    get user_watch_supplement_url(@user_watch_supplement), as: :json
    assert_response :success
  end

  test "should update user_watch_supplement" do
    patch user_watch_supplement_url(@user_watch_supplement), params: { user_watch_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_watch_supplement" do
    assert_difference('User::WatchSupplement.count', -1) do
      delete user_watch_supplement_url(@user_watch_supplement), as: :json
    end

    assert_response 204
  end
end
