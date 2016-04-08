class SitesController < ApplicationController
  before_action :logged_in_user?

  def index
    @sites = if params[:search]
               Site.search(params[:search]).order("LOWER(title) asc").page(params[:page])
             else
               Site.order("LOWER(title) asc").page(params[:page])
             end
  end

  def show
    @site = Site.find(params[:id])
    @articles = @site.articles.order("published desc").page(params[:page])
  end
end
