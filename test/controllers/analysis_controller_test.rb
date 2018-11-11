require 'test_helper'

class AnalysisControllerTest < ActionDispatch::IntegrationTest
  test "should get interaction" do
    get analysis_interaction_url
    assert_response :success
  end

end
