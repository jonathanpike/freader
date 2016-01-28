require 'test_helper'

class UsersControllerTest < ActionController::TestCase
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
end
