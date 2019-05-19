require 'rails_helper'

describe RatingsController::CreateFacade do
  let(:facade) { described_class.new(params, user_id) }
  let(:user_id) { 14 }

  let(:params) do
    ActionController::Parameters.new(
      interview_id: 4,
      comment_id: 7,
      positive: true
    )
  end

  describe '#call' do
    let(:rating) { instance_double(Rating, positive: false) }

    before do
      allow(Rating).to receive_messages(where: Rating)
      allow(Rating).to receive_messages(first_or_initialize: rating)
      allow(rating).to receive_messages(update!: true)
    end

    it 'changes a rating' do
      facade.call

      expect(rating).to have_received(:update!).with(positive: true)
    end
  end

  describe '#comment' do
    before do
      allow(Comment).to receive_messages(find: :comment)
      allow(CommentDecorator).to receive_messages(new: true)
    end

    it 'returns a decorated comment' do
      facade.comment

      expect(CommentDecorator).to have_received(:new).with(:comment)
    end
  end

  describe '#interview' do
    before do
      allow(Interview).to receive_messages(find: :interview)
    end

    it 'returns an interview' do
      facade.interview

      expect(Interview).to have_received(:find).with(4)
    end
  end
end
