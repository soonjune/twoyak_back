require 'test_helper'

class CurrentDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_drug = current_drugs(:one)
  end

  test "should get index" do
    get current_drugs_url, as: :json
    assert_response :success
  end

  test "should create current_drug" do
    assert_difference('CurrentDrug.count') do
      post current_drugs_url, params: { current_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show current_drug" do
    get current_drug_url(@current_drug), as: :json
    assert_response :success
  end

  test "should update current_drug" do
    patch current_drug_url(@current_drug), params: { current_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy current_drug" do
    assert_difference('CurrentDrug.count', -1) do
      delete current_drug_url(@current_drug), as: :json
    end

    assert_response 204
  end
end
