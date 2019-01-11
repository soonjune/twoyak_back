require 'test_helper'

class CurrentSupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_supplement = current_supplements(:one)
  end

  test "should get index" do
    get current_supplements_url, as: :json
    assert_response :success
  end

  test "should create current_supplement" do
    assert_difference('CurrentSupplement.count') do
      post current_supplements_url, params: { current_supplement: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show current_supplement" do
    get current_supplement_url(@current_supplement), as: :json
    assert_response :success
  end

  test "should update current_supplement" do
    patch current_supplement_url(@current_supplement), params: { current_supplement: {  } }, as: :json
    assert_response 200
  end

  test "should destroy current_supplement" do
    assert_difference('CurrentSupplement.count', -1) do
      delete current_supplement_url(@current_supplement), as: :json
    end

    assert_response 204
  end
end
