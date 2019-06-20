class InterviewsController::NewFacade
  include InterviewsController::Common

  def initialize(user_id)
    @user_id = user_id
  end

  def interview
    Interview.new(user_id: user_id, answers: answers)
  end

  private

  attr_reader :user_id

  def answers
    Section.ids.map do |section_id|
      Answer.new(content: '', section_id: section_id)
    end
  end
end
