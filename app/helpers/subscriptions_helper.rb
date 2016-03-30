module SubscriptionsHelper
  def any_articles?(sites)
    sites.each do |site|
      return true if site.articles.where("published >= ?", Time.zone.now.beginning_of_day).length > 0
    end
    false
  end

  def updated_sites?(site)
    site.articles.where("published >= ?", Time.zone.now.beginning_of_day).length > 0
  end
end
