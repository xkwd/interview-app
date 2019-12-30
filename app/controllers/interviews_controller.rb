class InterviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :user_interview, :update]

  def index
    @facade = IndexFacade.new(params, @search)

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
    @facade = CreateFacade.new(params, current_user.id)

    if @facade.save
      flash[:success] =
        "Whoa, your interview has been created. \
        It just needs a review before going public."
      redirect_to user_interviews_path
    else
      render 'new'
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
    @facade = UpdateFacade.new(params)

    if @facade.save
      flash[:success] = 'The interview has been updated'
      redirect_to user_interviews_path
    else
      render 'edit'
    end
  end
end
