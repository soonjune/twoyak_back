require 'test_helper'

class MypageControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mypage_create_url
    assert_response :success
  end

  test "should get show" do
    get mypage_show_url
    assert_response :success
  end

  test "should get update" do
    get mypage_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mypage_destroy_url
    assert_response :success
  end

end
