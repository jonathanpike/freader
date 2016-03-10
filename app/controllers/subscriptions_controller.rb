class SubscriptionsController < ApplicationController
  before_action :logged_in_user?

  def index
    @sites = current_user.sites.all.order("LOWER(title) asc")
  end

  def new 
    @subscription = Subscription.new
  end 

  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format| 
      if @subscription.save
        @subscription.add_feed_url
        @subscription.site_exists?
        flash.now[:notice] = "#{@subscription.url} successfully added"
        format.html { redirect_to yourdigest_path }
        format.js 
      else
        flash.now[:alert] = "Something went wrong.  Please try again."
        format.html { render 'new' }
        format.js 
      end
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:url, :user_id)
  end
end
