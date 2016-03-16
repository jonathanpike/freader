require 'feedbag'

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :site

  validates :url, presence: true, uniqueness: { scope: :user_id }
  validate :feed_url?, on: :create

  # Checks to see if Site exists in database.
  # If not, creates new site with same url and
  # feed_url as subscription
  def site_exists?
    if Site.exists?(url: url)
      update_attribute(:site_id,
                       Site.find_by(url: url).id)
    else
      new_site = Site.create(url: url,
                             feed_url: parse_feed_url)
      FetchSiteInformationJob.perform_later(new_site.id)
      update_attribute(:site_id, new_site.id)
    end
  end

  # Adds feed_url to subscription
  def add_feed_url
    return false if parse_feed_url.nil?
    update_attribute(:feed_url, parse_feed_url)
  end

  # Finds feed url from site <link> tag
  def parse_feed_url
    url = sanitize_url(self.url)
    Feedbag.find(url)[0]
  end

  private

  # Adds http:// if not provided to url
  def sanitize_url(url)
    return url if url.include?("https://") || url.include?("http://")
    url.prepend("http://")
  end

  def feed_url?
    return unless parse_feed_url.nil?
    errors.add(:base, "Sorry, we can't find a feed at this URL.")
  end
end
