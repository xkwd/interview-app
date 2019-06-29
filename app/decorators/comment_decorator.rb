class CommentDecorator < BaseDecorator
  def comments
    CommentDecorator.decorate_collection(object.comments)
  end

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

  def published_at
    object.created_at.strftime('%Y-%m-%d, %H:%M')
  end

  def author_name
    object.commenter_name || h.link_to(object.user.name, '#')
  end
end
