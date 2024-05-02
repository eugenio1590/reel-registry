class User < ApplicationRecord
  has_secure_password

  has_many :movies
  
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 10 }, password: true
end
