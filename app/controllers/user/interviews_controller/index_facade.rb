class User::InterviewsController::IndexFacade
  def initialize(user)
    @user = user
  end

  def interviews
    interviews =
      user
      .interviews
      .order('created_at DESC')

    InterviewDecorator.decorate_collection(interviews)
  end

  private

  attr_reader :user
end
