require 'test_helper'

class DiseasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disease = diseases(:one)
  end

  test "should get index" do
    get diseases_url, as: :json
    assert_response :success
  end

  test "should create disease" do
    assert_difference('Disease.count') do
      post diseases_url, params: { disease: { disease_name: @disease.disease_name } }, as: :json
    end

    assert_response 201
  end

  test "should show disease" do
    get disease_url(@disease), as: :json
    assert_response :success
  end

  test "should update disease" do
    patch disease_url(@disease), params: { disease: { disease_name: @disease.disease_name } }, as: :json
    assert_response 200
  end

  test "should destroy disease" do
    assert_difference('Disease.count', -1) do
      delete disease_url(@disease), as: :json
    end

    assert_response 204
  end
end
