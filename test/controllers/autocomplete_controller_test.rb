require 'test_helper'

class AutocompleteControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get autocomplete_search_url
    assert_response :success
  end

end
