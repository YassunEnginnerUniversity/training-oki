require "test_helper"

class Api::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_users_show_url
    assert_response :success
  end
end
