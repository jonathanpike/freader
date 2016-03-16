require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:cooper)
  end

  test "add new subscription" do
    log_in_as(@user)
    assert_difference 'Subscription.count' do
      post :create, subscription: { url: "http://leancrew.com/all-this/" }
    end
    assert_redirected_to yourdigest_path
    assert_not_nil flash[:notice]
  end

  test "add invalid subscription" do
    log_in_as(@user)
    assert_no_difference 'Subscription.count' do
      post :create, subscription: { url: "" }
    end
    assert_not_nil flash[:alert]
  end
end
