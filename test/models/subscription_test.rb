require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @user = users(:cooper)
    @feed = Subscription.create(url: "https://sivers.org/blog", user_id: @user.id)
    @site = subscriptions(:df)
  end

  test "parse feed works with valid feed address" do
    actual = @feed.parse_feed_url
    expected = "https://sivers.org/en.atom"
    assert_equal expected, actual
  end

  test "feed url is present" do
    @feed.add_feed_url
    actual = @feed.feed_url
    expected = "https://sivers.org/en.atom"
    assert_equal expected, actual
  end

  test "site_exists? with existant site" do
    assert_no_difference 'Site.count' do
      @site.site_exists?
    end
  end
end
