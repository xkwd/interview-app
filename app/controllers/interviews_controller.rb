class InterviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def index
    @interviews = Interview.all.order("created_at DESC")
  end

  def show
    @interview = Interview.find(params[:id])
  end

  def new
    @interview = current_user.interviews.build
    Section.all.each do |section|
      @interview.answers.build(
        content: "",
        section_id: section.id
      )
    end
  end

  def create
    @interview = current_user.interviews.build(interview_params)
    if @interview.save
      flash[:success] = 'Whoa, your interview has been created'
      redirect_to @interview
    else
      render 'new'
    end
  end

  def edit
    @interview = Interview.find(params[:id])
    unless @interview.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Interview'
      redirect_to interview_path
    end
  end

  def update
    @interview = Interview.find(params[:id])
    if @interview.update(interview_params)
      flash[:success] = 'The interview has been updated'
      redirect_to interview_path(@interview)
    else
      render 'edit'
    end
  end

  def user_interview
    @interviews = current_user.interviews.order("created_at DESC")
  end

  private

  def interview_params
    params.require(:interview).permit(:title, :description, answers_attributes:
                                     [:id, :content, :section_id])
  end

end
