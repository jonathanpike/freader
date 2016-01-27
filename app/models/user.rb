class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :sites, through: :subscriptions
end
