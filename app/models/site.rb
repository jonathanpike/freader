require 'feedjira'

class Site < ActiveRecord::Base
  has_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def fetch_information
    feed = Feedjira::Feed.fetch_and_parse feed_url
    update_attributes(title: feed.title)
  end
end
