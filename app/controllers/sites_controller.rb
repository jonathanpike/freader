class SitesController < ApplicationController
  before_action :logged_in_user?

  def index
    if params[:search]
      @sites = Site.search(params[:search]).order("LOWER(title) asc").page(params[:page])
    else
      @sites = Site.order("LOWER(title) asc").page(params[:page])
    end
  end

  def show
    @site = Site.find(params[:id])
    @articles = @site.articles.order("published desc").page(params[:page])
  end
end
