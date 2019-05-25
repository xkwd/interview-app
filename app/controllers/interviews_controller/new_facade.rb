class InterviewsController::NewFacade
  def initialize(user_id)
    @user_id = user_id
  end

  def interview
    Interview.new(user_id: user_id, answers: answers)
  end

  private

  attr_reader :user_id

  def answers
    answers = []

    Section.ids.each do |section_id|
      answers << Answer.new(content: '', section_id: section_id)
    end

    answers
  end
end
