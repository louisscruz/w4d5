module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def upvote_count
    self.votes.where(value: 1).count
  end

  def downvote_count
    self.votes.where(value: -1).count
  end
end
