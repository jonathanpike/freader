class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title
      t.string :author
      t.string :url
      t.timestamps null: false
    end
  end
end
