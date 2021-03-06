class Category < ActiveRecord::Base

  include Slugable

  has_many :post_categories
  has_many :posts, :through => :post_categories
  # validates_uniqueness_of :name
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  sluggable_column :name

  
end