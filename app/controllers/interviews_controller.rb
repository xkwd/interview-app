class InterviewsController < ApplicationController
  def index
    @interviews = Interview.all.order("created_at DESC")
  end

  def show
    @interview = Interview.find(params[:id])
  end

  def user_interview
    @interviews = current_user.interviews.order("created_at DESC")
  end

end
