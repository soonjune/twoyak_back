require 'test_helper'

class CurrentDiseasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_disease = current_diseases(:one)
  end

  test "should get index" do
    get current_diseases_url, as: :json
    assert_response :success
  end

  test "should create current_disease" do
    assert_difference('CurrentDisease.count') do
      post current_diseases_url, params: { current_disease: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show current_disease" do
    get current_disease_url(@current_disease), as: :json
    assert_response :success
  end

  test "should update current_disease" do
    patch current_disease_url(@current_disease), params: { current_disease: {  } }, as: :json
    assert_response 200
  end

  test "should destroy current_disease" do
    assert_difference('CurrentDisease.count', -1) do
      delete current_disease_url(@current_disease), as: :json
    end

    assert_response 204
  end
end
