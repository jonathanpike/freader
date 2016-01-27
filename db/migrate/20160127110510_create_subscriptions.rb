class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :url
      t.references :site, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
