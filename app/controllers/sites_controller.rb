class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    @articles = @site.articles.order("published desc").page(params[:page])
  end
end
