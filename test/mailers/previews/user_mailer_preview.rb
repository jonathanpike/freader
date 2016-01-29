# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def activation_email
    user = User.first
    user.activation_token = User.new_token
    UserMailer.activation_email(user)
  end
end
