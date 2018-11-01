require 'test_helper'

class DurIngrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dur_ingr = dur_ingrs(:one)
  end

  test "should get index" do
    get dur_ingrs_url, as: :json
    assert_response :success
  end

  test "should create dur_ingr" do
    assert_difference('DurIngr.count') do
      post dur_ingrs_url, params: { dur_ingr: { dur_code: @dur_ingr.dur_code, ingr_eng_name: @dur_ingr.ingr_eng_name, ingr_kor_name: @dur_ingr.ingr_kor_name, related_ingr_code: @dur_ingr.related_ingr_code, related_ingr_eng_name: @dur_ingr.related_ingr_eng_name, related_ingr_kor_name: @dur_ingr.related_ingr_kor_name } }, as: :json
    end

    assert_response 201
  end

  test "should show dur_ingr" do
    get dur_ingr_url(@dur_ingr), as: :json
    assert_response :success
  end

  test "should update dur_ingr" do
    patch dur_ingr_url(@dur_ingr), params: { dur_ingr: { dur_code: @dur_ingr.dur_code, ingr_eng_name: @dur_ingr.ingr_eng_name, ingr_kor_name: @dur_ingr.ingr_kor_name, related_ingr_code: @dur_ingr.related_ingr_code, related_ingr_eng_name: @dur_ingr.related_ingr_eng_name, related_ingr_kor_name: @dur_ingr.related_ingr_kor_name } }, as: :json
    assert_response 200
  end

  test "should destroy dur_ingr" do
    assert_difference('DurIngr.count', -1) do
      delete dur_ingr_url(@dur_ingr), as: :json
    end

    assert_response 204
  end
end
