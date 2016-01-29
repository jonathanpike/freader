class SessionsController < ApplicationController
  def new
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_to root_path
      else 
        flash[:alert] = "Please check your e-mail to activate your account"
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Incorrect username and password"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
