require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  def setup 
    @site = sites(:jp)
  end
  
  test "should show" do 
    get :show, id: @site.id
    assert_response :success
  end 
end
