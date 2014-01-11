module Voteable

  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size    
  end

  def say_hi
    puts "I can say Hello, thank you!"
  end
  
end