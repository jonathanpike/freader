class FetchNewArticlesJob < ActiveJob::Base
  queue_as :default

  def perform(site)
    site.fetch_articles
  end
end
