class UserMailer < ApplicationMailer
  default from: "no-reply@freader.com"
  
  def activation_email(user)
    @user = user
    mail(to: @user.email, subject: "Activate your Account")
  end
end
