class CommentDecorator < BaseDecorator
  def upvotes
    ratings.where(positive: true).count.to_s
  end

  def downvotes
    ratings.where(positive: false).count.to_s
  end

  def upvoted_by?(user)
    ratings.find_by(positive: true, user: user).present?
  end

  def downvoted_by?(user)
    ratings.find_by(positive: false, user: user).present?
  end
end
