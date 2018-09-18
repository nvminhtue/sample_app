class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\dasdasd\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save{email.downcase!}
  validates :name, presence: true, length: {maximum: Settings.user.name._max}
  validates :email, presence: true, length: {maximum: Settings.user.email._max},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: Settings.user.pass._min}
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
