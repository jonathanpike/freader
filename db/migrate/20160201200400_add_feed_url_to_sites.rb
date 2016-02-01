class AddFeedUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :feed_url, :string
  end
end
