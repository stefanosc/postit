class User < ActiveRecord::Base
  has_many :posts
  has_many :comments  

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create, length: {minimum: 3}
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true
end