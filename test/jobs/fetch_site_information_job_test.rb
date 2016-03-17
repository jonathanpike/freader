require 'test_helper'

class FetchSiteInformationJobTest < ActiveJob::TestCase
  def setup
    @site = sites(:jp)
  end

  test "site is updated with information" do
    assert_nil @site.title
    perform_enqueued_jobs do
      FetchSiteInformationJob.perform_later(@site.id)
    end
    assert_performed_jobs 1
    assert_equal "Personal Development", @site.reload.title
  end
end
