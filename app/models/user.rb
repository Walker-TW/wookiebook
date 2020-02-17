class User < ApplicationRecord
  has_many :posts, dependent: :restrict_with_exception
  validates :email, uniqueness: true
  validates_with EmailValidator
  validates :password, length: { within: 6..10 }

  after_validation(on: :create) do
    self.password = BCrypt::Password.create(password)
  end
end