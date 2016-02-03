require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    @site = sites(:df)
  end

  test "fetch information gets title" do
    assert_nil @site.title
    @site.fetch_information
    assert_match @site.title, "Daring Fireball"
  end
end
