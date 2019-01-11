require 'test_helper'

class PastDiseasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @past_disease = past_diseases(:one)
  end

  test "should get index" do
    get past_diseases_url, as: :json
    assert_response :success
  end

  test "should create past_disease" do
    assert_difference('PastDisease.count') do
      post past_diseases_url, params: { past_disease: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show past_disease" do
    get past_disease_url(@past_disease), as: :json
    assert_response :success
  end

  test "should update past_disease" do
    patch past_disease_url(@past_disease), params: { past_disease: {  } }, as: :json
    assert_response 200
  end

  test "should destroy past_disease" do
    assert_difference('PastDisease.count', -1) do
      delete past_disease_url(@past_disease), as: :json
    end

    assert_response 204
  end
end
