require 'test_helper'

class DrugReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug_review = drug_reviews(:one)
  end

  test "should get index" do
    get drug_reviews_url, as: :json
    assert_response :success
  end

  test "should create drug_review" do
    assert_difference('DrugReview.count') do
      post drug_reviews_url, params: { drug_review: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show drug_review" do
    get drug_review_url(@drug_review), as: :json
    assert_response :success
  end

  test "should update drug_review" do
    patch drug_review_url(@drug_review), params: { drug_review: {  } }, as: :json
    assert_response 200
  end

  test "should destroy drug_review" do
    assert_difference('DrugReview.count', -1) do
      delete drug_review_url(@drug_review), as: :json
    end

    assert_response 204
  end
end
