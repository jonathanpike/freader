require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "activation email" do 
    user = users(:cooper)
    user.activation_token = User.new_token
    mail = UserMailer.activation_email(user)
    assert_equal "Activate your Account", mail.subject
    assert_equal ["no-reply@freader.com"], mail.from
    assert_equal [user.email], mail.to
    assert_match user.name, mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
end
