require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "", email: "user@invalid", password:"foo" ,password_confirmation: "bar" }}
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "valid signup information" do
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name:  "testuser", email: "user@valid.com", password:"testusertestuser" ,password_confirmation: "testusertestuser" }}
    end
    follow_redirect!
    assert_template 'users/show'
    assert flash[:success]
  end
end
