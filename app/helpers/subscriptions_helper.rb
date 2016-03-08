module SubscriptionsHelper
  def any_articles?(site)
    site.articles.where("published >= ?", Time.zone.now.beginning_of_day).length > 0
  end
end
