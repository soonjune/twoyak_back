require 'test_helper'

class WatchSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @watch_supplement = watch_supplements(:one)
  end

  test "should get index" do
    get watch_supplements_url, as: :json
    assert_response :success
  end

  test "should create watch_supplement" do
    assert_difference('WatchSupplement.count') do
      post watch_supplements_url, params: { watch_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show watch_supplement" do
    get watch_supplement_url(@watch_supplement), as: :json
    assert_response :success
  end

  test "should update watch_supplement" do
    patch watch_supplement_url(@watch_supplement), params: { watch_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy watch_supplement" do
    assert_difference('WatchSupplement.count', -1) do
      delete watch_supplement_url(@watch_supplement), as: :json
    end

    assert_response 204
  end
end
