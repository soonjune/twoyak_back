require 'test_helper'

class SupplementIngrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @supplement_ingr = supplement_ingrs(:one)
  end

  test "should get index" do
    get supplement_ingrs_url, as: :json
    assert_response :success
  end

  test "should create supplement_ingr" do
    assert_difference('SupplementIngr.count') do
      post supplement_ingrs_url, params: { supplement_ingr: { active_ingr: @supplement_ingr.active_ingr, approval_no: @supplement_ingr.approval_no, benefits: @supplement_ingr.benefits, daily_intake: @supplement_ingr.daily_intake, daily_intake_max: @supplement_ingr.daily_intake_max, daily_intake_min: @supplement_ingr.daily_intake_min, enterprise_name: @supplement_ingr.enterprise_name, ingr_name: @supplement_ingr.ingr_name, warnings: @supplement_ingr.warnings } }, as: :json
    end

    assert_response 201
  end

  test "should show supplement_ingr" do
    get supplement_ingr_url(@supplement_ingr), as: :json
    assert_response :success
  end

  test "should update supplement_ingr" do
    patch supplement_ingr_url(@supplement_ingr), params: { supplement_ingr: { active_ingr: @supplement_ingr.active_ingr, approval_no: @supplement_ingr.approval_no, benefits: @supplement_ingr.benefits, daily_intake: @supplement_ingr.daily_intake, daily_intake_max: @supplement_ingr.daily_intake_max, daily_intake_min: @supplement_ingr.daily_intake_min, enterprise_name: @supplement_ingr.enterprise_name, ingr_name: @supplement_ingr.ingr_name, warnings: @supplement_ingr.warnings } }, as: :json
    assert_response 200
  end

  test "should destroy supplement_ingr" do
    assert_difference('SupplementIngr.count', -1) do
      delete supplement_ingr_url(@supplement_ingr), as: :json
    end

    assert_response 204
  end
end
