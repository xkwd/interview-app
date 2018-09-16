require "rails_helper"

describe CommentServices::CreateComment do
  subject { described_class.new(params).call }

  let(:interview) { create(:interview) }
  let(:commenter) { create(:user) }
  let(:commentable_type) { "Interview" }
  let(:comment_body) { "comment body" }
  let!(:params) do
    {
      commentable_type: commentable_type,
      commentable_id: interview.id,
      user_id: commenter.id,
      body: comment_body,
    }
  end

  context "when params are valid" do
    it "returns success" do
      expect(subject.success?).to eq(true)
    end

    it "adds a new comment" do
      expect { subject }.to change(Comment, :count).by(1)
    end

    it "creates a comment with proper attributes", :aggregate_failures do
      subject
      new_comment = Comment.last
      expect(new_comment.user_id).to eq(commenter.id)
      expect(new_comment.body).to eq(params[:body])
      expect(new_comment.commentable_type).to eq("Interview")
      expect(new_comment.commentable_id).to eq(interview.id)
    end
  end

  context "when params are invalid" do
    let(:commentable_type) { "random" }
    let(:comment_body) { "comment body" }

    it "returns failure" do
      expect(subject.failure?).to eq(true)
    end

    it "does not add a new comment" do
      expect { subject }.not_to change(Comment, :count)
    end
  end
end
