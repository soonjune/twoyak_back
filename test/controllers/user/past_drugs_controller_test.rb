require 'test_helper'

class User::PastDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_past_drug = user_past_drugs(:one)
  end

  test "should get index" do
    get user_past_drugs_url, as: :json
    assert_response :success
  end

  test "should create user_past_drug" do
    assert_difference('User::PastDrug.count') do
      post user_past_drugs_url, params: { user_past_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show user_past_drug" do
    get user_past_drug_url(@user_past_drug), as: :json
    assert_response :success
  end

  test "should update user_past_drug" do
    patch user_past_drug_url(@user_past_drug), params: { user_past_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy user_past_drug" do
    assert_difference('User::PastDrug.count', -1) do
      delete user_past_drug_url(@user_past_drug), as: :json
    end

    assert_response 204
  end
end
