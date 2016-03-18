module SitesHelper
  include UtilityFunctions

  def subscription_button_helper(site)
    if subscribed?(site.id)
      link_to 'Subscribed!', subscription_path(site.id), method: :put, remote: true, class: "button"
    else
      link_to 'Subscribe', subscription_path(site.id), method: :put, remote: true, class: "button"
    end
  end
end
