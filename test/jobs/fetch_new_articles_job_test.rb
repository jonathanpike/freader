require 'test_helper'

class FetchNewArticlesJobTest < ActiveJob::TestCase
  def setup
    @site = sites(:marco)
  end

  test "site is updated with new articles" do
    assert @site.articles.count == 0
    FetchNewArticlesJob.perform_now(@site.id)
    assert @site.articles.count > 0
  end
end
