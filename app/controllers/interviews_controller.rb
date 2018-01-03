class InterviewsController < ApplicationController
  def index
    @interviews = Interview.all.order("created_at DESC")
  end

  def show
    @interview = Interview.find(params[:id])
  end

end
