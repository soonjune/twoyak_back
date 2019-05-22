require 'test_helper'

class DrugIngrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug_ingr = drug_ingrs(:one)
  end

  test "should get index" do
    get drug_ingrs_url, as: :json
    assert_response :success
  end

  test "should create drug_ingr" do
    assert_difference('DrugIngr.count') do
      post drug_ingrs_url, params: { drug_ingr: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show drug_ingr" do
    get drug_ingr_url(@drug_ingr), as: :json
    assert_response :success
  end

  test "should update drug_ingr" do
    patch drug_ingr_url(@drug_ingr), params: { drug_ingr: {  } }, as: :json
    assert_response 200
  end

  test "should destroy drug_ingr" do
    assert_difference('DrugIngr.count', -1) do
      delete drug_ingr_url(@drug_ingr), as: :json
    end

    assert_response 204
  end
end
