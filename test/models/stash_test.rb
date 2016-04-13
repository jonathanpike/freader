require 'test_helper'

class StashTest < ActiveSupport::TestCase
  def setup
    @user = users(:cooper)
    @article = articles(:article_one)
  end

  test "Create new Stash, Stash is unique" do
    assert @user.stashes.count == 0
    assert_difference 'Stash.count' do
      Stash.create(user_id: @user.id, article_id: @article.id)
    end

    assert_no_difference 'Stash.count' do
      Stash.create(user_id: @user.id, article_id: @article.id)
    end
  end
end
