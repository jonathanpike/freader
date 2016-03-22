require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    @df = sites(:df)
    @jp = sites(:jp)
  end

  test "fetch information gets title" do
    assert_nil @df.title
    @df.fetch_information
    assert_match @df.title, "Daring Fireball"
  end

  test "fetch articles adds articles" do
    assert @jp.articles.length == 0
    @jp.fetch_articles
    assert_equal 10, @jp.articles.count
  end

  test "reading time displays time" do
    @jp.fetch_articles
    assert_not_nil @jp.reload.articles.last.readingtime
  end
end
