class CommentDecorator < SimpleDelegator
  def initialize(comment)
    @comment = comment
    super
  end

  def upvotes
    ratings.where(positive: true).count
  end

  def downvotes
    ratings.where(positive: false).count
  end
end
