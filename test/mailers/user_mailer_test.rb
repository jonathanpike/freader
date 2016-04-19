require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "activation email" do
    user = users(:cooper)
    user.activation_token = User.new_token
    mail = UserMailer.activation_email(user)
    assert_equal "Activate your Account", mail.subject
    assert_equal ["no-reply@thedigest.io"], mail.from
    assert_equal [user.email], mail.to
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end

  test "reset email" do
    user = users(:cooper)
    user.reset_token = User.new_token
    mail = UserMailer.reset_email(user)
    assert_equal "Reset your Password", mail.subject
    assert_equal ["no-reply@thedigest.io"], mail.from
    assert_equal [user.email], mail.to
    assert_match user.name, mail.body.encoded
    assert_match user.reset_token, mail.body.encoded
    assert_match CGI.escape(user.email), mail.body.encoded
  end
end
