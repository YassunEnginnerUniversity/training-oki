require "test_helper"

class ApplicationHelperText < ActionView::TestCase
  test "full title helper" do
    assert_equal "Ruby on Rails Tutorial Sample App" , full_title
    assert_equal "Contact | Ruby on Rails Tutorial Sample App" , full_title("Contact")
    assert_equal "Sign up | Ruby on Rails Tutorial Sample App" , full_title("Sign up")
  end
end