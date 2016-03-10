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
    if @subscription.save
      @subscription.add_feed_url
      @subscription.site_exists?
      respond_to do |format| 
        format.html do 
          flash[:notice] = "Feed successfully added"
          redirect_to yourdigest_path
        end
        format.js 
      end
    else
      respond_to do |format| 
        format.html do 
          flash.now[:alert] = "Something went wrong.  Please try again."
          render 'new'
        end
        format.js
      end
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:url, :user_id)
  end
end
