require 'test_helper'

class AddingSubscriptionsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:cooper)
  end

  test "add new subscription" do
    log_in_as(@user, remember_me: '1')
    assert is_logged_in?
    get new_subscription_path
    assert_difference 'Subscription.count' do
      post subscriptions_path, subscription: { url: "http://blog.codinghorror.com/" }
    end
    assert_redirected_to yourdigest_path
    assert_not_nil flash[:notice]
  end
end
