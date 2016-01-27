class Site < ActiveRecord::Base
  has_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
