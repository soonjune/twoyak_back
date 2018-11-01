require 'test_helper'

class DrugsDurIngrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drugs_dur_ingr = drugs_dur_ingrs(:one)
  end

  test "should get index" do
    get drugs_dur_ingrs_url, as: :json
    assert_response :success
  end

  test "should create drugs_dur_ingr" do
    assert_difference('DrugsDurIngr.count') do
      post drugs_dur_ingrs_url, params: { drugs_dur_ingr: { drug_id: @drugs_dur_ingr.drug_id, dur_ingr_id: @drugs_dur_ingr.dur_ingr_id } }, as: :json
    end

    assert_response 201
  end

  test "should show drugs_dur_ingr" do
    get drugs_dur_ingr_url(@drugs_dur_ingr), as: :json
    assert_response :success
  end

  test "should update drugs_dur_ingr" do
    patch drugs_dur_ingr_url(@drugs_dur_ingr), params: { drugs_dur_ingr: { drug_id: @drugs_dur_ingr.drug_id, dur_ingr_id: @drugs_dur_ingr.dur_ingr_id } }, as: :json
    assert_response 200
  end

  test "should destroy drugs_dur_ingr" do
    assert_difference('DrugsDurIngr.count', -1) do
      delete drugs_dur_ingr_url(@drugs_dur_ingr), as: :json
    end

    assert_response 204
  end
end
