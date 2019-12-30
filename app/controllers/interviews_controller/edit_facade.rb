class InterviewsController::EditFacade
  include InterviewsController::Common

  def initialize(interview_id, user_id)
    @interview_id = interview_id
    @user_id = user_id
  end

  def interview
    @interview ||= Interview.find(interview_id)
  end

  def authorized?
    interview.user_id == user_id
  end

  private

  attr_reader :interview_id, :user_id
end
