class InterviewDecorator < SimpleDelegator
  def self.decorate(interview)
    new(interview)
  end

  def self.decorate_collection(collection)
    collection.map { |interview| decorate(interview) }
  end

  def publication_status
    published? ? "Published on #{published_at}" : 'Unpublished'
  end

  def published_at
    created_at.strftime('%A, %B %e, %Y')
  end
end
