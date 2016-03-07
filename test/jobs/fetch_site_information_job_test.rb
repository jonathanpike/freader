require 'test_helper'

class FetchSiteInformationJobTest < ActiveJob::TestCase
  def setup
    @site = sites(:jp)
  end

  test "site is updated with information" do
    assert_nil @site.title
    FetchSiteInformationJob.perform_now(@site.id)
    assert_equal "Personal Development", @site.reload.title
  end
end
