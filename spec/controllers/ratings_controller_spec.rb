require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let!(:user)       { create(:user) }
  let(:interview)   { create(:interview) }
  let(:comment)     { create(:comment) }

  describe "POST upvote" do
    let(:subject) { post :upvote, params: { comment_id: comment.id, interview_id: interview.id } }

    context "when a guest user is upvoting" do
      context "and has not upvoted yet" do
        it "adds an upvote to a comment" do
          expect { subject }.to change(Rating, :count).by(1)
        end
      end

      context "and has already upvoted" do
        it "does not add an upvote to a comment" do
          subject
          expect { subject }.not_to change(Rating, :count)
        end
      end

      it "redirects to an interview page" do
        expect(subject).to redirect_to(interview_path(interview))
      end
    end

    context "when a signed in user is upvoting" do
      before do
        sign_in user
      end

      context "and has not upvoted yet" do
        it "adds an upvote to a comment" do
          expect { subject }.to change(Rating, :count).by(1)
        end
      end

      context "and has already upvoted" do
        it "does not add an upvote to a comment" do
          subject
          expect { subject }.not_to change(Rating, :count)
        end
      end

      it "redirects to an interview page" do
        expect(subject).to redirect_to(interview_path(interview))
      end
    end
  end

  describe "POST downvote" do
    let(:subject) { post :downvote, params: { comment_id: comment.id, interview_id: interview.id } }

    context "when a guest user is downvoting" do
      context "and has not downvoted yet" do
        it "adds a downvote to a comment" do
          expect { subject }.to change(Rating, :count).by(1)
        end
      end

      context "and has already downvoted" do
        it "does not add a downvote to a comment" do
          subject
          expect { subject }.not_to change(Rating, :count)
        end
      end

      it "redirects to an interview page" do
        expect(subject).to redirect_to(interview_path(interview))
      end
    end

    context "when a signed in user is downvoting" do
      before do
        sign_in user
      end

      context "and has not downvoted yet" do
        it "adds a downvote to a comment" do
          expect { subject }.to change(Rating, :count).by(1)
        end
      end

      context "and has already downvoted" do
        it "does not add a downvote to a comment" do
          subject
          expect { subject }.not_to change(Rating, :count)
        end
      end

      it "redirects to an interview page" do
        expect(subject).to redirect_to(interview_path(interview))
      end
    end
  end
end
