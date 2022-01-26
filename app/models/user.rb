class User < ActiveRecord::Base

  has_secure_password

  before_validation { email.downcase! }

  validates :email, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
end
