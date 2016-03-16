class ResetsController < ApplicationController
  before_action :find_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  layout "marketing"

  def new
  end

  def create
    @user = User.find_by(email: params[:reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_reset_email
      flash[:notice] = "Please check your e-mail for a password reset link"
      redirect_to root_path
    else
      flash.now[:alert] = "E-mail address not registered"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:notice] = "Password successfully reset."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated? &&
           @user.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  # rubocop:disable Style/GuardClause
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_reset_path
    end
  end
end
