require 'test_helper'

class User::CurrentDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_current_drug = user_current_drugs(:one)
  end

  test "should get index" do
    get user_current_drugs_url, as: :json
    assert_response :success
  end

  test "should create user_current_drug" do
    assert_difference('User::CurrentDrug.count') do
      post user_current_drugs_url, params: { user_current_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_current_drug" do
    get user_current_drug_url(@user_current_drug), as: :json
    assert_response :success
  end

  test "should update user_current_drug" do
    patch user_current_drug_url(@user_current_drug), params: { user_current_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_current_drug" do
    assert_difference('User::CurrentDrug.count', -1) do
      delete user_current_drug_url(@user_current_drug), as: :json
    end

    assert_response 204
  end
end
