require 'test_helper'

class PastSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @past_supplement = past_supplements(:one)
  end

  test "should get index" do
    get past_supplements_url, as: :json
    assert_response :success
  end

  test "should create past_supplement" do
    assert_difference('PastSupplement.count') do
      post past_supplements_url, params: { past_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show past_supplement" do
    get past_supplement_url(@past_supplement), as: :json
    assert_response :success
  end

  test "should update past_supplement" do
    patch past_supplement_url(@past_supplement), params: { past_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy past_supplement" do
    assert_difference('PastSupplement.count', -1) do
      delete past_supplement_url(@past_supplement), as: :json
    end

    assert_response 204
  end
end
