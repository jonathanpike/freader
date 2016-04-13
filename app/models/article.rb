class Article < ActiveRecord::Base
  belongs_to :site
  has_many :stashes

  validates :title, uniqueness: true
end
