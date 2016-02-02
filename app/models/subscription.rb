require 'feedbag'

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  
  validates :url, presence: true
  
  def site_exists?
    if Site.exists?(url: self.url)
      update_attribute(:site_id, 
                       Site.find_by(url: self.url).id)
    else 
      new_site = Site.create(url: self.url, 
                             feed_url: self.parse_feed_url)
      update_attribute(:site_id, new_site.id)
    end
  end 
  
  def add_feed_url 
    update_attribute(:feed_url, parse_feed_url)
  end
  
  def parse_feed_url
    url = sanitize_url(self.url)
    Feedbag.find(url)[0]
  end
  
  private
  
  def sanitize_url(url)
    return url if url.include?("https://") || url.include?("http://")
    url.prepend("http://")
  end
end
