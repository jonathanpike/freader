require 'test_helper'

class FetchNewArticlesJobTest < ActiveJob::TestCase
  def setup
    @site = sites(:marco)
  end

  test "site is updated with new articles" do
    assert @site.articles.count == 0
    perform_enqueued_jobs do
      FetchNewArticlesJob.perform_later(@site.id)
    end
    assert_performed_jobs 1
    assert @site.articles.count > 0
  end
end
