class User < ActiveRecord::Base

  include Slugable

  has_many :posts
  has_many :comments  
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create, length: {minimum: 4}
  validates :password, length: {minimum: 4, maximum: 120}, on: :update, allow_blank: true

  sluggable_column :username

  def admin?
    self.role.to_s.to_sym == :admin
  end

end