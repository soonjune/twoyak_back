require 'test_helper'

class User::WatchDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_watch_drug = user_watch_drugs(:one)
  end

  test "should get index" do
    get user_watch_drugs_url, as: :json
    assert_response :success
  end

  test "should create user_watch_drug" do
    assert_difference('User::WatchDrug.count') do
      post user_watch_drugs_url, params: { user_watch_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_watch_drug" do
    get user_watch_drug_url(@user_watch_drug), as: :json
    assert_response :success
  end

  test "should update user_watch_drug" do
    patch user_watch_drug_url(@user_watch_drug), params: { user_watch_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_watch_drug" do
    assert_difference('User::WatchDrug.count', -1) do
      delete user_watch_drug_url(@user_watch_drug), as: :json
    end

    assert_response 204
  end
end
