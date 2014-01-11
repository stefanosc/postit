class Comment < ActiveRecord::Base

  include Voteable

  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  after_create :set_random_slug

  private

  def set_random_slug
    self.slug = SecureRandom.urlsafe_base64
  end

end