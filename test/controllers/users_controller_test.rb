require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:cooper)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create new user" do
    assert_difference 'User.count' do
      post :create, user: { name: "Bob Dylan",
                            email: "bob@dylan.com",
                            password: "password",
                            password_confirmation: "password" }
    end
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @user.id
    assert_response :success
  end

  test "Need to be logged in to edit" do
    get :edit, id: @user.id
    assert_redirected_to login_path
  end

  test "should update user email" do
    log_in_as(@user)
    assert_equal "cooper@interstellar.com", @user.email
    put :update, id: @user.id, user: { name: @user.name,
                                       email: "changed@interstellar.com",
                                       current_password: "password" }
    assert_redirected_to dashboard_path
    assert_equal "changed@interstellar.com", @user.reload.email
  end
end
