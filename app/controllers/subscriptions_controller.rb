class SubscriptionsController < ApplicationController
  before_action :logged_in_user?

  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      @subscription.add_feed_url
      @subscription.site_exists?
      flash[:notice] = "Feed successfully added"
      redirect_to root_path
    else
      flash[:alert] = "Something went wrong.  Please try again."
      render 'new'
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:url, :user_id)
  end
end
