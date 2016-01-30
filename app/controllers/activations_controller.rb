class ActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:notice] = "Thanks for activating your account!"
    else
      flash[:alert] = "Incorrect activation token."
    end
    redirect_to root_path
  end
end
