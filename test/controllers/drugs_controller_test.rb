require 'test_helper'

class DrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug = drugs(:one)
  end

  test "should get index" do
    get drugs_url, as: :json
    assert_response :success
  end

  test "should create drug" do
    assert_difference('Drug.count') do
      post drugs_url, params: { drug: { atc_code: @drug.atc_code, ingr_eng_name: @drug.ingr_eng_name, ingr_kor_name: @drug.ingr_kor_name, item_name: @drug.item_name, item_seq: @drug.item_seq, package_insert: @drug.package_insert } }, as: :json
    end

    assert_response 201
  end

  test "should show drug" do
    get drug_url(@drug), as: :json
    assert_response :success
  end

  test "should update drug" do
    patch drug_url(@drug), params: { drug: { atc_code: @drug.atc_code, ingr_eng_name: @drug.ingr_eng_name, ingr_kor_name: @drug.ingr_kor_name, item_name: @drug.item_name, item_seq: @drug.item_seq, package_insert: @drug.package_insert } }, as: :json
    assert_response 200
  end

  test "should destroy drug" do
    assert_difference('Drug.count', -1) do
      delete drug_url(@drug), as: :json
    end

    assert_response 204
  end
end
