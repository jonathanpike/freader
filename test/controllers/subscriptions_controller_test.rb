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
end
