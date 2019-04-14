require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let!(:user)       { create(:user) }
  let(:interview)   { create(:interview) }
  let(:comment)     { create(:comment) }
  let(:params)      { { comment_id: comment.id, interview_id: interview.id } }

  shared_examples "handling votes and redirecting" do
    context "and has not voted yet" do
      it "adds a vote to a comment" do
        expect { subject }.to change(Rating, :count).by(1)
      end
    end

    context "and has already voted" do
      it "does not add a vote to a comment" do
        subject
        expect { subject }.not_to change(Rating, :count)
      end
    end

    it "redirects to an interview page" do
      expect(subject).to redirect_to(interview_path(interview))
    end
  end

  describe "POST upvote" do
    let(:subject) { post :upvote, params: params }

    context "when a guest user is upvoting" do
      include_examples "handling votes and redirecting"
    end

    context "when a signed in user is upvoting" do
      before do
        sign_in user
      end

      include_examples "handling votes and redirecting"
    end
  end

  describe "POST downvote" do
    let(:subject) { post :downvote, params: params }

    context "when a guest user is downvoting" do
      include_examples "handling votes and redirecting"
    end

    context "when a signed in user is downvoting" do
      before do
        sign_in user
      end

      include_examples "handling votes and redirecting"
    end
  end
end
