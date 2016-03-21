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

  test "need to be logged in to get index" do
    get :index
    assert_redirected_to login_path
  end

  test "should get show" do
    log_in_as(@user)
    get :show, id: @site.id
    assert_response :success
  end

  test "need to be logged in to get show" do
    get :show, id: @site.id
    assert_redirected_to login_path
  end
end
