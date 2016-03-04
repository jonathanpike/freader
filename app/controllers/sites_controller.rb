class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    @articles = @site.articles.page(params[:page])
  end
end
