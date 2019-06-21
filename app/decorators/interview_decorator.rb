class InterviewDecorator < BaseDecorator
  def comments
    @comments ||=
      CommentDecorator.decorate_collection(object.comments)
  end

  def publication_status
    return "Published on #{published_at}" if published?

    'Unpublished'
  end

  def published_at
    created_at.strftime('%A, %B %e, %Y')
  end
end
