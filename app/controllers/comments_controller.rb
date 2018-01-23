class CommentsController < ApplicationController
  before_action :fetch_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)

    if @comment.save
      redirect_back fallback_location: @commentable, notice: "Your comment was posted"
    else
      redirect_back fallback_location: @commentable, notice: "Something went wrong with your comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:commentable_type, :commentable_id, :body,
                                      :commenter_name, :commenter_email, :user_id)
    end

    def fetch_commentable
      @commentable = comment_params[:commentable_type].classify.constantize.find(comment_params[:commentable_id])
    end
end
