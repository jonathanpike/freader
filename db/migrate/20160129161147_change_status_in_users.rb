class ChangeStatusInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :status, :activated
    add_column :users, :activated_at, :datetime
  end
end
