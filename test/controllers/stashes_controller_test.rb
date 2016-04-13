require 'test_helper'

class StashesControllerTest < ActionController::TestCase
  def setup
    @user = users(:cooper)
    @brand = users(:brand)
    @article = articles(:article_one)
    @stash = stashes(:stash_one)
  end

  test "Should get Stash Index" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

  test "Need to be logged in to get Index" do
    get :index
    assert_redirected_to login_path
  end

  test "Should create new Stash" do
    log_in_as(@user)
    assert_difference "Stash.count" do
      post :create, stash: { user_id: @user.id, article_id: @article.id }
    end
    assert_redirected_to mydigest_path
  end

  test "Must be logged in to create new Stash" do
    assert_no_difference "Stash.count" do
      post :create, stash: { user_id: @user.id, article_id: @article.id }
    end
    assert_redirected_to login_path
  end

  test "Should delete Stash" do
    log_in_as(@brand)
    assert @brand.stashes.count > 0
    assert_difference "Stash.count", -1 do
      delete :destroy, id: @stash.id
    end
    assert @brand.stashes.count == 0
  end

  test "Should not be able to delete other user's Stashed item" do
    log_in_as(@user)
    assert @brand.stashes.count == 1
    assert_no_difference 'Stash.count' do
      delete :destroy, id: @stash.id
    end
  end
end
