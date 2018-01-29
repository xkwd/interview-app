require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:interview) { FactoryBot.create(:interview) }
  let(:comment) { FactoryBot.create(:comment, commentable: interview) }
  let(:invalid_comment) { FactoryBot.build(:comment, commenter_name: nil, user_id: nil) }

  context "when params are valid" do
    it "creates a new comment" do
      params = { interview_id: interview.id, comment: comment.attributes }
      expect { post :create, xhr: true, params: params, format: :js }.to change(Comment, :count).by(1)
    end

    it "renders 200" do
      params = { interview_id: interview.id, comment: comment.attributes }
      post :create, xhr: true, params: params, format: :js
      expect(response.status).to be(200)
    end
  end

  context "when params are invalid" do
    it "does not create a new comment" do
      params = { interview_id: interview.id, comment: invalid_comment.attributes }
      expect { post :create, xhr: true, params: params, format: :js }.not_to change(Comment, :count)
    end
  end

end
