class RatingsController < ApplicationController
  def upvote
    vote(positive: true)
  end

  def downvote
    vote(positive: false)
  end

  private

  def vote(positive:)
    @comment = Comment.find(params[:comment_id])
    @decorated_comment = CommentDecorator.new(Comment.find(params[:comment_id]))
    @interview = Interview.find(params[:interview_id])
    set_rating(positive: positive)

    respond_to do |format|
      format.html { redirect_to @interview }
      format.js
    end
  end

  def set_rating(positive:)
    rating = Rating.where(comment_id: params[:comment_id], user_id: current_or_guest_user.id).first_or_initialize
    rating.positive = positive
    rating.save
  end
end
