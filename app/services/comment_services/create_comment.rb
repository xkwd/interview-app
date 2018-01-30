module CommentServices
  class CreateComment
    def initialize(params)
      @params = params
    end

    def call
      @commentable = fetch_commentable
      return false if @commentable.blank?
      comment = @commentable.comments.new(@params)
      comment.save
    end

    def fetch_commentable
      @params[:commentable_type].classify.constantize.find(@params[:commentable_id])
    end
  end
end
