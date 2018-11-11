require 'test_helper'

class SearchTermsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search_term = search_terms(:one)
  end

  test "should get index" do
    get search_terms_url, as: :json
    assert_response :success
  end

  test "should create search_term" do
    assert_difference('SearchTerm.count') do
      post search_terms_url, params: { search_term: { terms: @search_term.terms } }, as: :json
    end

    assert_response 201
  end

  test "should show search_term" do
    get search_term_url(@search_term), as: :json
    assert_response :success
  end

  test "should update search_term" do
    patch search_term_url(@search_term), params: { search_term: { terms: @search_term.terms } }, as: :json
    assert_response 200
  end

  test "should destroy search_term" do
    assert_difference('SearchTerm.count', -1) do
      delete search_term_url(@search_term), as: :json
    end

    assert_response 204
  end
end
