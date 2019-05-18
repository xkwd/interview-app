require 'rails_helper'

describe RatingsController, type: :controller do
  let!(:user)       { create(:user) }
  let(:interview)   { create(:interview) }
  let(:comment)     { create(:comment) }

  let(:params) do
    {
      comment_id: comment.id,
      interview_id: interview.id,
      positive: positive
    }
  end

  shared_examples 'handling votes and redirecting' do
    context 'without previous upvotes' do
      it 'adds a vote to a comment' do
        expect { subject }.to change(Rating, :count).by(1)
      end
    end

    context 'with previous upvotes' do
      it 'does not add a vote to a comment' do
        subject
        expect { subject }.not_to change(Rating, :count)
      end
    end

    it 'redirects to an interview page' do
      expect(subject).to redirect_to(interview_path(interview))
    end
  end

  describe 'POST #create' do
    let(:subject) { post :create, params: params }

    context 'when a guest user is upvoting' do
      let(:positive) { true }

      include_examples 'handling votes and redirecting'
    end

    context 'when a signed in user is upvoting' do
      let(:positive) { true }

      before do
        sign_in user
      end

      include_examples 'handling votes and redirecting'
    end

    context 'when a guest user is downvoting' do
      let(:positive) { false }

      include_examples 'handling votes and redirecting'
    end

    context 'when a signed in user is downvoting' do
      let(:positive) { false }

      before do
        sign_in user
      end

      include_examples 'handling votes and redirecting'
    end
  end
end
