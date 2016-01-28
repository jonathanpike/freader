require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup 
    @user = users(:cooper)
  end
  
  test "invalid login" do
    get login_path
    post login_path, session: { email: "blah@blah.com",
                                password: "  " }
    assert_template 'sessions/new'
    assert_equal flash[:alert], "Incorrect username and password"
    get root_path
    assert_nil flash[:alert]
  end
  
  test "log in and log out" do 
    get login_path 
    post login_path, session: { email: @user.email, password: "password" }
    assert logged_in?
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/index'
    delete logout_path
    assert_not logged_in?
    assert_redirected_to root_path
  end
end
