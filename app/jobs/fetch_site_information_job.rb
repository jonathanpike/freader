class FetchSiteInformationJob < ActiveJob::Base
  queue_as :default

  def perform(site_id)
    site = Site.find(site_id)
    site.fetch_information
  end
end
