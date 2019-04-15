class RatingsController < ApplicationController
  def upvote
    vote(positive: true)
  end

  def downvote
    vote(positive: false)
  end

  private

  def vote(positive:)
    rating = Rating.where(comment_id: params[:comment_id], user_id: current_or_guest_user.id).first_or_initialize
    rating.positive = positive
    rating.save
    alert = positive ? "You've already upvoted this comment" : "You've already downvoted this comment"
    flash[:alert] = alert unless rating.saved_change_to_positive?
    @comment = CommentDecorator.new(Comment.find(params[:comment_id]))
    @interview = Interview.find(params[:interview_id])

    respond_to do |format|
      format.html { redirect_to @interview }
      format.js
    end
  end
end
