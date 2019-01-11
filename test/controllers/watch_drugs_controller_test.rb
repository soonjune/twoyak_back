require 'test_helper'

class WatchDrugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @watch_drug = watch_drugs(:one)
  end

  test "should get index" do
    get watch_drugs_url, as: :json
    assert_response :success
  end

  test "should create watch_drug" do
    assert_difference('WatchDrug.count') do
      post watch_drugs_url, params: { watch_drug: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show watch_drug" do
    get watch_drug_url(@watch_drug), as: :json
    assert_response :success
  end

  test "should update watch_drug" do
    patch watch_drug_url(@watch_drug), params: { watch_drug: {  } }, as: :json
    assert_response 200
  end

  test "should destroy watch_drug" do
    assert_difference('WatchDrug.count', -1) do
      delete watch_drug_url(@watch_drug), as: :json
    end

    assert_response 204
  end
end
