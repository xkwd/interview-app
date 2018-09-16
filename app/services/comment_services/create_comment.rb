require "dry/monads/all"

module CommentServices
  class CreateComment
    include Dry::Monads

    def initialize(params)
      @params = params
    end

    def call
      fetch_commentable.bind(method(:create_comment))
    end

    private

    def fetch_commentable
      commentable = @params[:commentable_type].classify.constantize.find_by(id: @params[:commentable_id])
      return Failure(commentable.errors) if commentable.blank?
      Success(commentable)
    rescue NameError
      Failure("non existing class")
    end

    def create_comment(commentable)
      comment = commentable.comments.new(@params)
      Success(comment.save)
    end
  end
end
