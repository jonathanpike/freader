class SubscriptionsController < ApplicationController
  before_action :logged_in_user?
  include ActionView::Helpers::TextHelper

  def index
    @sites = current_user.sites.order("LOWER(sites.title) asc")
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @subscription = Subscription.new
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    @subscription = Subscription.new(subscription_params)
    respond_to do |format|
      if @subscription.save
        @subscription.add_feed_url
        @subscription.site_exists?
        flash.now[:notice] = "#{@subscription.url} successfully added"
        format.html { redirect_to yourdigest_path }
      else
        flash.now[:alert] = @subscription.errors.full_messages.to_sentence
        format.html { render 'new' }
      end
      format.js
    end
  end

  def manage
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy_multiple
    @sites = params[:site_id]

    @sites[0].each_key do |key|
      Subscription.where(site_id: key.to_i, user_id: current_user.id).destroy_all
    end

    names = Site.find(@sites[0].keys).map(&:title).join(", ")

    flash.now[:notice] = "Successfully removed the following #{pluralize(@sites[0].count, 'subscription')}: #{names}"

    respond_to do |format|
      format.html { redirect_to yourdigest_path }
      format.js
    end
  end

  def destroy
  end

  private

  def subscription_params
    params.require(:subscription).permit(:url, :user_id)
  end
end
