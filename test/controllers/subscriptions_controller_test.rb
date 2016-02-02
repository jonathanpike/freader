require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:cooper)
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "can't get new when not logged in" do
    get :new
    assert_redirected_to login_url
    assert_not_nil flash[:alert]
  end

  test "add new subscription" do
    log_in_as(@user)
    assert_difference 'Subscription.count' do
      post :create, subscription: { url: "jonathanpike.net" }
    end
    assert_redirected_to root_path
    assert_not_nil flash[:notice]
  end

  test "add invalid subscription" do
    log_in_as(@user)
    assert_no_difference 'Subscription.count' do
      post :create, subscription: { url: "" }
    end
    assert_template 'subscriptions/new'
    assert_not_nil flash[:alert]
  end
end
