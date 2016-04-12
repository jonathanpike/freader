class Article < ActiveRecord::Base
  belongs_to :site
  belongs_to :stash

  validates :title, uniqueness: true
end
