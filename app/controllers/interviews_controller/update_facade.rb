class InterviewsController::UpdateFacade
  def initialize(params)
    @params = params
  end

  def interview
    @interview ||= Interview.find(params[:id])
  end

  def save
    interview.update!(interview_params)
  end

  private

  attr_reader :params

  def interview_params
    params
      .require(:interview)
      .permit(
        :title,
        :description,
        :country_id,
        :cover,
        answers_attributes: [
          :id,
          :content,
          :section_id,
          :image,
        ]
      )
  end
end
