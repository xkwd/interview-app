class User::InterviewsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @facade = IndexFacade.new(current_user)
  end
end
