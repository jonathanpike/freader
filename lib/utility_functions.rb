module UtilityFunctions
  def subscribed?(site_id)
    return true if current_user.subscriptions.where(site_id: site_id).exists?
    false
  end
end
