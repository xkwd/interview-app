class RatingsController::CreateFacade
  def self.call(*args)
    new(*args).call
  end

  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def call
    rate
    self
  end

  def comment
    comment = Comment.find(params[:comment_id])
    @comment ||= CommentDecorator.new(comment)
  end

  def interview
    @interview ||= Interview.find(params[:interview_id])
  end

  private

  attr_reader :params, :user_id

  def rate
    rating.update!(positive: params[:positive])
  end

  def rating
    @rating ||= Rating.where(
      comment_id: params[:comment_id],
      user_id: user_id
    ).first_or_initialize
  end
end
