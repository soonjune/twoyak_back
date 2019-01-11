require 'test_helper'

class PastDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @past_drug = past_drugs(:one)
  end

  test "should get index" do
    get past_drugs_url, as: :json
    assert_response :success
  end

  test "should create past_drug" do
    assert_difference('PastDrug.count') do
      post past_drugs_url, params: { past_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show past_drug" do
    get past_drug_url(@past_drug), as: :json
    assert_response :success
  end

  test "should update past_drug" do
    patch past_drug_url(@past_drug), params: { past_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy past_drug" do
    assert_difference('PastDrug.count', -1) do
      delete past_drug_url(@past_drug), as: :json
    end

    assert_response 204
  end
end
