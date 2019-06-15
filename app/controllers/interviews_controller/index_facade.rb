class InterviewsController::IndexFacade
  def initialize(params, search)
    @params = params
    @search = search
  end

  def interviews
    interviews =
      search
      .result(distinct: true)
      .includes(:answers)
      .page(params[:page])
      .per(2)

    if params[:q].blank?
      interviews.padding(2)
    else
      interviews
    end
  end

  def top_interviews
    Interview.published.last(2)
  end

  private

  attr_reader :params, :search
end
