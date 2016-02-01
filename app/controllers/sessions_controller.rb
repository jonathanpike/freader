class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      activated_log_in(@user)
      redirect_back_or(root_path)
    else
      flash.now[:alert] = "Incorrect username and password"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def activated_log_in(user)
    message = "Please check your e-mail to activate your account"
    return flash[:alert] = message unless user.activated?
    log_in user
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  end
end
