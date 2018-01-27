class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    result = CommentServices::CreateComment.new(comment_params).call

    if result
      redirect_to interview_path(id: params[:interview_id]),
        notice: "Your comment was posted"
    else
      redirect_to interview_path(id: params[:interview_id]),
        notice: "Something went wrong with your comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:commentable_type, :commentable_id, :body,
                                      :commenter_name, :commenter_email, :user_id)
    end
end
