require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:interview) { FactoryBot.create(:interview) }
  let(:comment) { FactoryBot.create(:comment) }
  let(:invalid_comment) { FactoryBot.build(:comment, commenter_name: nil, user_id: nil) }

  context "when params are valid" do
    it "creates a new comment" do
      params = { interview_id: interview.id, comment: comment.attributes }
      expect { post :create, params: params }.to change(Comment, :count).by(1)
    end

    it "redirects to the interview page upon save" do
      params = { interview_id: interview.id, comment: comment.attributes }
      post :create, params: params
      expect(response).to redirect_to Interview.find(comment.commentable_id)
    end
  end

  context "when params are invalid" do
    it "does not create a new comment" do
      params = { interview_id: interview.id, comment: invalid_comment.attributes }
      expect { post :create, params: params }.not_to change(Comment, :count)
    end
  end

end
