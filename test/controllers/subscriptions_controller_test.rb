require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:cooper)
    @brand = users(:brand)
  end

  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

  test "need to be logged in to get index" do
    get :index
    assert_redirected_to login_path
  end

  test "add new subscription" do
    log_in_as(@user)
    assert_difference 'Subscription.count' do
      post :create, subscription: { url: "https://jonathanpike.net",
                                    user_id: @user.id }
    end
    assert_redirected_to mydigest_path
    assert_not_nil flash[:notice]
  end

  test "need to be logged in to add subscription" do
    assert_no_difference 'Subscription.count' do
      post :create, subscription: { url: "http://leancrew.com/all-this/" }
    end
    assert_redirected_to login_path
  end

  test "add invalid subscription" do
    log_in_as(@user)
    assert_no_difference 'Subscription.count' do
      post :create, subscription: { url: "" }
    end
    assert_not_nil flash[:alert]
  end

  test "remove single subscription" do
    log_in_as(@brand)
    sub = @brand.subscriptions.first
    assert_difference 'Subscription.count', -1 do
      put :update, id: sub.site_id
    end

    assert_not_nil flash[:notice]
    assert_redirected_to site_path(sub.site_id)
  end

  test "need to be logged in to remove subscription" do
    sub = @brand.subscriptions.first
    assert_no_difference 'Subscription.count' do
      put :update, id: sub.site_id
    end
    assert_redirected_to login_path
  end

  test "destroy multiple subscriptions" do
    log_in_as(@brand)
    assert_equal 10, @brand.subscriptions.count

    # Format IDs in way that method is expecting
    # Hash with id => id
    arr = @brand.subscriptions.all.map(&:site_id)
    a = (arr + arr.dup).sort
    hash = Hash[a.each_slice(2).to_a]

    delete :destroy_multiple, site_id: [hash]

    assert_equal 0, @brand.subscriptions.count
    assert_not_nil flash[:notice]
  end
end
