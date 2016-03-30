require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    @df = sites(:df)
    @jp = sites(:jp)
    @marco = sites(:marco)
    @article = articles(:article_one)
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

  test "added? doesn't allow second article to be added" do
    assert @marco.articles.length == 1
    assert_no_difference '@marco.articles.count' do
      unless Article.where(title: "Article One").exists?
        Article.create(title: "Article One",
                       description: "This is my description",
                       published: DateTime.new(2005, 2, 3, 4, 5, 6).in_time_zone,
                       site_id: @marco.id)
      end
      unless Article.where(site_id: @marco.id, published: DateTime.new(2001, 2, 3, 4, 5, 6).in_time_zone).exists?
        Article.create(title: "Article Oone",
                       description: "This is my description",
                       published: DateTime.new(2001, 2, 3, 4, 5, 6).in_time_zone,
                       site_id: @marco.id)
      end
    end
    assert @marco.articles.length == 1
  end
end
