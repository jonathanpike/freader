class FetchNewArticlesJob < ActiveJob::Base
  queue_as :default

  def perform(site_id)
    site = Site.find(site_id)
    site.fetch_articles
  end
end
