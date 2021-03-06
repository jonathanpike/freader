class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :sites, through: :subscriptions
  has_many :stashes

  attr_accessor :remember_token, :activation_token, :reset_token

  before_save :email_downcase
  before_create :new_activation_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 8 }, allow_nil: true

  has_secure_password

  def auth_and_update(user_params)
    current_password = user_params.delete(:current_password)

    if authenticate(current_password)
      update(user_params)
      true
    else
      errors.add(:password, current_password.blank? ? :blank : :invalid)
      false
    end
  end

  # Remember Me Methods
  # Generates a remember token and saves a hash to the DB
  # for later comparison
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Deletes remember token
  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def send_reset_email
    UserMailer.reset_email(self).deliver_now
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.activation_email(self).deliver_now
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def self.digest(password)
    # rubocop:disable Style/MultilineTernaryOperator
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(password, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private

  def email_downcase
    self.email = email.downcase
  end

  def new_activation_token
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
