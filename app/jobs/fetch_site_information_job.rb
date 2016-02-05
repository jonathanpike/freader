class FetchSiteInformationJob < ActiveJob::Base
  queue_as :default

  def perform(site)
    site.fetch_information
  end
end
