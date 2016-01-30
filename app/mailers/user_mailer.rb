class UserMailer < ApplicationMailer
  default from: "no-reply@freader.com"

  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Activate your Account")
  end

  def reset_email(user)
    @user = user
    mail(to: @user.email, subject: "Reset your Password")
  end
end
