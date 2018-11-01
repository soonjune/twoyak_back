require 'test_helper'

class SupplementIngrsSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplement_ingrs_supplement = supplement_ingrs_supplements(:one)
  end

  test "should get index" do
    get supplement_ingrs_supplements_url, as: :json
    assert_response :success
  end

  test "should create supplement_ingrs_supplement" do
    assert_difference('SupplementIngrsSupplement.count') do
      post supplement_ingrs_supplements_url, params: { supplement_ingrs_supplement: { supplement_id: @supplement_ingrs_supplement.supplement_id, supplement_ingr_id: @supplement_ingrs_supplement.supplement_ingr_id } }, as: :json
    end

    assert_response 201
  end

  test "should show supplement_ingrs_supplement" do
    get supplement_ingrs_supplement_url(@supplement_ingrs_supplement), as: :json
    assert_response :success
  end

  test "should update supplement_ingrs_supplement" do
    patch supplement_ingrs_supplement_url(@supplement_ingrs_supplement), params: { supplement_ingrs_supplement: { supplement_id: @supplement_ingrs_supplement.supplement_id, supplement_ingr_id: @supplement_ingrs_supplement.supplement_ingr_id } }, as: :json
    assert_response 200
  end

  test "should destroy supplement_ingrs_supplement" do
    assert_difference('SupplementIngrsSupplement.count', -1) do
      delete supplement_ingrs_supplement_url(@supplement_ingrs_supplement), as: :json
    end

    assert_response 204
  end
end
