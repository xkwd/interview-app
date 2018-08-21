class InterviewForm < Reform::Form
  property :name, virtual: true
  property :title
  property :description
  property :country_id
  property :user

  validates :title, :description, :country_id, presence: true
  validate :author_presence

  def initialize(model, params = {})
    super
    @author = params[:author]
  end

  def prepopulate!
    self.name = @author.name
  end

  def save
    ::ActiveRecord::Base.transaction do
      @author.update!(name: name) if name.present?
      model.update!(
        title: title,
        description: description,
        user_id: @author.id,
        country_id: country_id
      )
    end
  end

  private

  def author_presence
    return true if @author.present?
    errors.add(:user, 'should be provided')
  end
end
