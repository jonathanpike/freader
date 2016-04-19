module SubscriptionsHelper
  def any_articles?(sites)
    sites.each do |site|
      return true if site.articles.where("published >= ?", range).length > 0
    end
    false
  end

  def updated_sites?(site)
    site.articles.where("published >= ?", range).length > 0
  end

  def range
    if params[:date]
      Time.zone.parse(params[:date])
    else
      Time.zone.now.beginning_of_day
    end
  end
end
