class User < ActiveRecord::Base

  has_secure_password

  before_validation { email.downcase! }

  validates :email, uniqueness: true
  validates :password, presence: true, length: 5..25
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)

    if user && user.authenticate(password)
      return user
    end
      return nil
  end
end
