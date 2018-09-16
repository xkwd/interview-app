class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    result = CommentServices::CreateComment.new(comment_params).call

    if result.success?
      flash[:notice] = "Your comment was posted"
      @interview = Interview.find(params[:interview_id])
    else
      flash[:alert] = "Something went wrong with your comment"
    end

    respond_to do |format|
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:commentable_type, :commentable_id, :body,
                                      :commenter_name, :commenter_email, :user_id)
    end
end
