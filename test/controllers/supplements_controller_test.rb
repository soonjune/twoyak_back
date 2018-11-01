require 'test_helper'

class SupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplement = supplements(:one)
  end

  test "should get index" do
    get supplements_url, as: :json
    assert_response :success
  end

  test "should create supplement" do
    assert_difference('Supplement.count') do
      post supplements_url, params: { supplement: { approval_date: @supplement.approval_date, benefits: @supplement.benefits, description: @supplement.description, enterprise_name: @supplement.enterprise_name, ingredients: @supplement.ingredients, product_name: @supplement.product_name, production_code: @supplement.production_code, shelf_life: @supplement.shelf_life, standard: @supplement.standard, storage: @supplement.storage, suggested_use: @supplement.suggested_use, warnings: @supplement.warnings } }, as: :json
    end

    assert_response 201
  end

  test "should show supplement" do
    get supplement_url(@supplement), as: :json
    assert_response :success
  end

  test "should update supplement" do
    patch supplement_url(@supplement), params: { supplement: { approval_date: @supplement.approval_date, benefits: @supplement.benefits, description: @supplement.description, enterprise_name: @supplement.enterprise_name, ingredients: @supplement.ingredients, product_name: @supplement.product_name, production_code: @supplement.production_code, shelf_life: @supplement.shelf_life, standard: @supplement.standard, storage: @supplement.storage, suggested_use: @supplement.suggested_use, warnings: @supplement.warnings } }, as: :json
    assert_response 200
  end

  test "should destroy supplement" do
    assert_difference('Supplement.count', -1) do
      delete supplement_url(@supplement), as: :json
    end

    assert_response 204
  end
end
