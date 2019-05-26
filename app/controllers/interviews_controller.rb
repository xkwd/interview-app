class InterviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :user_interview]
  before_action :set_interview, only: [:update]
  before_action :countries_list, only: [:new, :create, :edit, :new_form]

  def index
    @interviews = @search.result(distinct: true).includes(:answers).page(params[:page]).per(2)

    if params[:q].blank?
      @top_interviews = Interview.published.last(2)
      @interviews = @interviews.padding(2)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @facade = ShowFacade.new(params)
  end

  def new
    @facade = NewFacade.new(current_user.id)
  end

  def create
    @interview = current_user.interviews.build(interview_params)
    if @interview.save
      flash[:success] = "Whoa, your interview has been created.
                         It just needs a review before going public."
      redirect_to my_interviews_path
    else
      render "new"
    end
  end

  def edit
    @facade = EditFacade.new(params[:id], current_user.id)

    if @facade.authorized?
      render 'edit'
    else
      flash[:notice] = 'Access denied as you are not an owner of this interview'
      redirect_to interview_path
    end
  end

  def update
    if @interview.update(interview_params)
      flash[:success] = "The interview has been updated"
      redirect_to interview_path(@interview)
    else
      render "edit"
    end
  end

  def user_interview
    user_interviews = current_user.interviews.order('created_at DESC')
    @decorated_user_interviews = InterviewDecorator.decorate_collection(user_interviews)
  end

  def search
    index
    render :index
  end

  def new_form
    @form = InterviewForm.new(Interview.new, author: current_user)
    @form.prepopulate!
  end

  def create_form
    @form = InterviewForm.new(Interview.new, author: current_user)

    if @form.validate(params[:interview])
      @form.save
      redirect_to "/my_interviews"
    else
      render "new_form"
    end
  end

  private

  def interview_params
    params.require(:interview).permit(:title, :description, :country_id, :cover, answers_attributes:
                                     [:id, :content, :section_id, :image])
  end

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def countries_list
    @countries_list ||= Country.all.map { |c| [c.name, c.id] }
  end
end
