require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  def setup
    @site = sites(:jp)
    @user = users(:cooper)
  end

  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

  test "should get show" do
    log_in_as(@user)
    get :show, id: @site.id
    assert_response :success
  end
end
