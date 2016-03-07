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
    assert is_logged_in?
    assert_redirected_to yourdigest_path
    follow_redirect!
    assert_template 'subscriptions/index'
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    delete logout_path # Second browser logout
    follow_redirect!
  end

  test "login with remember" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end

  test "login without remember" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end
