class RemoveAuthorFromSite < ActiveRecord::Migration
  def change
    remove_column :sites, :author
  end
end
