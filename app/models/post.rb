class Post < ActiveRecord::Base
  
  # scope :votes, -> {order("votes desc")}

  include Voteable
  include Slugable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments
  has_many :post_categories
  has_many :categories, :through => :post_categories

  validates :title, :description, :url, presence: true
  validates_uniqueness_of :url, { case_sensitive: false }

  sluggable_column :title

  # def to_json(options={})
  #   {
  #     # :title => title,
  #     :User => User.find(user_id).username,
  #     :description => description,
  #     :created_at => created_at,
  #     :updated_at => updated_at,
  #     :url => url,
  #     :slug => slug
  #   }
  # end

  def as_json(options = {})
    json = {:title => title, :description => description} # whatever info you want to expose
    json[:author] = creator.as_json(options) if options[:include_creator]
    json
  end

end