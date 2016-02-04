require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  def setup
    @rss = Subscription.create(url: "https://marco.org")
    @atom = Subscription.create(url: "http://daringfireball.net")
    @site = Site.create(title: "Daring Fireball",
                        url: "http://daringfireball.net",
                        feed_url: "http://daringfireball.net/feeds/main")
  end

  test "parse feed works with valid rss address" do
    actual = @rss.parse_feed_url
    expected = "http://marco.org/rss"
    assert_equal expected, actual
  end

  test "parse feed works with valid atom address" do
    actual = @atom.parse_feed_url
    expected = "http://daringfireball.net/feeds/main"
    assert_equal expected, actual
  end

  test "feed url is present" do
    @rss.add_feed_url
    actual = @rss.feed_url
    expected = "http://marco.org/rss"
    assert_equal expected, actual
  end

  test "site_exists? with non-existant site" do
    assert_nil Site.find_by(url: @rss.url)
    assert_difference 'Site.count' do
      @rss.site_exists?
    end
    site = Site.find_by(url: @rss.url)
    assert_equal @rss.site_id, site.id
  end

  test "site_exists? with existant site" do
    assert_no_difference 'Site.count' do
      @atom.site_exists?
    end
    assert_equal @atom.site_id, @site.id
  end
end
