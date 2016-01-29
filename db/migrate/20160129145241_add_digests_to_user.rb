class AddDigestsToUser < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :reset_digest, :string
  end
end
