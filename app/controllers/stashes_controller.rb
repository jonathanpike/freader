class StashesController < ApplicationController
  before_action :logged_in_user?

  def index
    @stashes = current_user.stashes.page(params[:page])
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def create
    @stash = Stash.new(stash_params)
    respond_to do |format|
      if @stash.save
        store_location
        flash.now[:notice] = "'#{@stash.article.title}' successfully stashed"
      else
        flash.now[:alert] = @stash.errors.full_messages.to_sentence
      end
      format.html { redirect_back_or(mydigest_path) }
      format.js
    end
  end

  def destroy
    @stash = Stash.find(params[:id])
    if @stash.user_id == current_user.id
      @stash.destroy
      flash.now[:notice] = "'#{@stash.article.title}' successfully unstashed"
      store_location
    else
      flash.now[:alert] = "That stashed item doesn't belong to you."
    end
    respond_to do |format|
      format.html { redirect_back_or(mydigest_path) }
      format.js
    end
  end

  private

  def stash_params
    params.require(:stash).permit(:user_id, :article_id)
  end
end
