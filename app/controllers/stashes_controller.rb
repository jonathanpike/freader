class StashesController < ApplicationController
  def index
  end 
  
  def create
    @stash = Stash.new(stash_params)
     respond_to do |format|
      if @stash.save
        flash.now[:notice] = "'#{@stash.article.title}' successfully stashed"
      else
        flash.now[:alert] = @stash.errors.full_messages.to_sentence
      end
      format.html { redirect_to mydigest_path }
      format.js
    end
  end 
  
  def destroy
    @stash = Stash.find(params[:id])
    @stash.destroy
    flash.now[:notice] = "'#{@stash.article.title}' successfully unstashed"
  end 
  
  private 
  
  def stash_params
    params.require(:stash).permit(:user_id, :article_id)
  end 
end
