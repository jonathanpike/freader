class AddReadingtimeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :readingtime, :string
  end
end
