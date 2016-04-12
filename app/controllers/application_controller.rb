class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :new_subscription
  helper_method :subscribed_sites
  helper_method :any_subscriptions?
  helper_method :user

  # rubocop:disable Style/GuardClause
  def logged_in_user?
    unless logged_in?
      store_location
      flash[:alert] = "Please log in."
      redirect_to login_url
    end
  end

  def new_subscription
    Subscription.new
  end

  def subscribed_sites
    current_user.sites.order("LOWER(title) asc")
  end

  def any_subscriptions?
    current_user.subscriptions.any?
  end
  
  def user 
    User.new
  end 
end
