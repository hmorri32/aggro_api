class User < ApplicationRecord
  validates :email,    presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password

  before_save :downcase_email

  private
    def downcase_email
      self.email = self.email.delete(' ').downcase if self.email
    end
end
