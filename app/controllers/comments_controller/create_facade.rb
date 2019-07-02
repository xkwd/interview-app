class CommentsController::CreateFacade
  def initialize(params)
    @params = params
  end

  def comment
    Comment.new(
      comment_params.merge(commentable_type: commentable_type)
    )
  end

  def interview
    @interview ||=
      InterviewDecorator.new(
        Interview.find(params[:interview_id])
      )
  end

  delegate :save, to: :comment

  private

  attr_reader :params

  def comment_params
    params
      .require(:comment)
      .permit(
        :commentable_type,
        :commentable_id,
        :body,
        :commenter_name,
        :commenter_email,
        :user_id
      )
  end

  def commentable_type
    comment_params[:commentable_type]
      .classify
      .gsub(/Decorator/, '')
  end
end
