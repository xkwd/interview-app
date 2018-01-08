class InterviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def index
    @interviews = Interview.all.order("created_at DESC")
  end

  def show
    @interview = Interview.find(params[:id])
  end

  def edit
    @interview = Interview.find(params[:id])
    unless @interview.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Interview'
      redirect_to interview_path
     end
  end

  def user_interview
    @interviews = current_user.interviews.order("created_at DESC")
  end

end
