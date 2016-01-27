class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.datetime :published
      t.references :site, index: true
      t.timestamps null: false
    end
  end
end
