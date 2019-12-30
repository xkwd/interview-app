class CommentsController < ApplicationController
  def create
    @facade = CreateFacade.new(params)

    if @facade.save
      flash[:notice] = 'Your comment has been posted'
    else
      flash[:alert] = 'Something went wrong with your comment'
    end

    respond_to do |format|
      format.js
    end
  end
end
