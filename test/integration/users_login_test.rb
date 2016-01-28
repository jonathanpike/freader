require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "invalid login" do
    get login_path
    post login_path, session: { email: "blah@blah.com",
                                password: "  " }
    assert_template 'sessions/new'
    assert_equal flash[:alert], "Incorrect username and password"
    get root_path
    assert_nil flash[:alert]
  end
end
