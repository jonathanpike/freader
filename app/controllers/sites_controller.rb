class SitesController < ApplicationController
  before_action :logged_in_user?
  
  def show
    @site = Site.find(params[:id])
    @articles = @site.articles.order("published desc").page(params[:page])
  end
end
