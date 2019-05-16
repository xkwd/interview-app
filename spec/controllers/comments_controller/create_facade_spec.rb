require 'rails_helper'

describe CommentsController::CreateFacade do
  let(:facade) { described_class.new(params) }

  let(:params) do
    ActionController::Parameters.new(
      interview_id: 4,
      comment: {
        commentable_type: 'Comment',
        commentable_id: 7,
        body: 'Some comment here',
        commenter_name: 'John',
        commenter_email: 'john@example.com',
        user_id: nil
      }
    )
  end

  describe '#comment' do
    let(:commentable) { instance_double(Comment, comments: comments) }
    let(:comments) { double }
    let(:comment) { instance_double(Comment) }

    before do
      allow(Comment).to receive_messages(find: commentable)
      allow(comments).to receive_messages(new: comment)
    end

    it 'initializes a new comment' do
      expect(facade.comment).to eq comment
    end
  end

  describe '#save' do
    subject { described_class.new(params) }

    it { should delegate_method(:save).to(:comment) }
  end

  describe '#interview' do
    before do
      allow(Interview).to receive_messages(find: :interview)
    end

    it 'finds an interview' do
      facade.interview

      expect(Interview).to have_received(:find).with(4)
    end
  end
end
