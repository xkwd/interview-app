class RatingsController < ApplicationController
  def create
    @facade = CreateFacade.call(params, current_or_guest_user.id)

    respond_to do |format|
      format.js
    end
  end
end
