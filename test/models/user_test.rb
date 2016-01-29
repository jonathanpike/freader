require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "bobdylan",
                     password_confirmation: "bobdylan")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "name length should be < 50" do
    @user.name = "A" * 51
    assert_not @user.valid?
  end

  test "email length should be < 255" do
    @user.email = "A" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be valid" do
    valid_addresses = %w(prettyandsimple@example.com very.common@example.com
                         disposable.style.email.with+symbol@example.com
                         other.email-with-dash@example.com)
    valid_addresses.each do |valid|
      @user.email = valid
      assert @user.valid?, "#{valid.inspect} must be a valid e-mail address"
    end

    invalid_addresses = %w(Abc.example.com A@b@c@example.com blah@example
                           invalid@address,com)
    invalid_addresses.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?, "#{invalid.inspect} must be a valid e-mail address"
    end
  end

  test "email must be unique" do
    @user.save
    user2 = User.new(name: "Example User",
                     email: "user@example.com",
                     password: "bobdylan",
                     password_confirmation: "bobdylan")

    assert_not user2.valid?

    user2.email = user2.email.upcase

    assert_not user2.valid?
  end

  test "email is saved in downcase" do
    user2 = User.new(name: "Example User",
                     email: "USER@EXAMPLE.COM",
                     password: "bobdylan",
                     password_confirmation: "bobdylan")
    user2.save
    assert_equal user2.email, "user@example.com"
  end

  test "password should not be blank" do
    @user.password = "    "
    assert_not @user.valid?
  end

  test "password length should be > 8" do
    @user.password = "bob"
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with a nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
