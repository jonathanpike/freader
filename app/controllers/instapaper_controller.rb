class InstapaperController < ApplicationController
  def new
    @instapaper = Instapaper.new
    @url = params[:url]
    render layout: "popup"
  end

  def create
    @instapaper = Instapaper.new
    @instapaper.create(instapaper_params[:username], instapaper_params[:password])
    if @instapaper.authenticate
      @instapaper.add(instapaper_params[:url])
      flash[:notice] = "Successfully saved to Instapaper!"
    else
      flash.now[:alert] = "Your Instapaper username or password is incorrect"
    end
  end

  private

  def instapaper_params
    params.require(:instapaper).permit(:username, :password, :url)
  end
end
