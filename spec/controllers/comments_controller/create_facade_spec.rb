require 'rails_helper'

describe CommentsController::CreateFacade do
  let(:facade) { described_class.new(params) }
  let(:commentable_type) { 'Interview' }

  let(:params) do
    ActionController::Parameters.new(
      interview_id: 4,
      comment: {
        commentable_type: commentable_type,
        commentable_id: 7,
        body: 'Some comment here',
        commenter_name: 'John',
        commenter_email: 'john@example.com',
        user_id: nil
      }
    )
  end

  let(:received_params) do
    ActionController::Parameters.new(
      commentable_type: 'Interview',
      commentable_id: 7,
      body: 'Some comment here',
      commenter_name: 'John',
      commenter_email: 'john@example.com',
      user_id: nil
    ).permit!
  end

  before do
    allow(Comment).to receive_messages(new: :comment)
  end

  describe '#comment' do
    it 'initializes a new comment' do
      facade.comment

      expect(Comment)
        .to have_received(:new)
        .with(received_params)
    end

    context 'with a decorator in the commentable_type' do
      let(:commentable_type) { 'InterviewDecorator' }

      it 'initializes a new comment' do
        facade.comment

        expect(Comment)
          .to have_received(:new)
          .with(received_params)
      end
    end
  end

  describe '#save' do
    subject { described_class.new(params) }

    it { should delegate_method(:save).to(:comment) }
  end

  describe '#interview' do
    before do
      allow(InterviewDecorator)
        .to receive_messages(new: :decorated_interview)
      allow(Interview)
        .to receive_messages(find: :interview)
    end

    it 'finds an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:find)
        .with(4)
    end

    it 'decorated an interview' do
      facade.interview

      expect(InterviewDecorator)
        .to have_received(:new)
        .with(:interview)
    end
  end
end
