class InterviewsController::CreateFacade
  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def interview
    @interview ||= Interview.new(interview_params)
  end

  def save
    interview.save
  end

  private

  attr_reader :params, :user_id

  def interview_params
    params
      .require(:interview)
      .permit(:title,
              :description,
              :country_id,
              :cover,
              answers_attributes: [
                :id,
                :content,
                :section_id,
                :image,
              ])
      .merge(user_id: user_id)
  end
end
