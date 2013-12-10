class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, :through => :post_categories
  validates_uniqueness_of :name
  validates :name, presence: true
end