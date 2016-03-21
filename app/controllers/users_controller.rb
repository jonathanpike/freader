class UsersController < ApplicationController
  before_action :logged_in_user?, only: [:edit, :update]
  layout "marketing"

  def show
    @user = current_user
    render layout: "application"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "Please check your e-mail to activate your account"
      redirect_to mydigest_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    render layout: "application"
  end

  def update
    @user = current_user
    if @user.auth_and_update(user_params)
      flash[:notice] = "Profile successfully updated"
      redirect_to dashboard_path
    else
      flash[:alert] = "Profile not updated.  See error messages below:"
      render :edit, layout: "application"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
