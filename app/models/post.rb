class Post < ActiveRecord::Base
  
  # scope :votes, -> {order("votes desc")}


  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :post_categories
  has_many :categories, :through => :post_categories
  has_many :votes, as: :votable

  validates :title, :description, :url, presence: true
  validates_uniqueness_of :url, { case_sensitive: false }

  include CalculateVotes

end