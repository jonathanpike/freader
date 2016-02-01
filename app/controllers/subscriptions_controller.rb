class SubscriptionsController < ApplicationController
  before_action :logged_in_user?

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
  end

  private

  def subscription_params
    params.require(:subscription).permit(:url)
  end
end
