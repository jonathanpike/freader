class AddFeedUrlToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :feed_url, :string
  end
end
