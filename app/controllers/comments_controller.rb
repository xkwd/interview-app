class CommentsController < ApplicationController
  def create
    @facade = CreateFacade.new(params)

    if @facade.save
      flash[:notice] = 'Your comment has been posted'
      # FIXME: Remove this instance variable when
      #   other controllers are refactored using facades
      @interview = Interview.find(params[:interview_id])
    else
      flash[:alert] = 'Something went wrong with your comment'
    end

    respond_to do |format|
      format.js
    end
  end
end
