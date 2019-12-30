class InterviewsController::ShowFacade
  def initialize(params)
    @params = params
  end

  def interview
    @interview ||=
      InterviewDecorator.new(
        Interview.published.find(params[:id])
      )
  end

  private

  attr_reader :params
end
