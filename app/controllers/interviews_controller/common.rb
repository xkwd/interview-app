module InterviewsController::Common
  def countries
    @countries ||= Country.pluck(:name, :id)
  end
end
