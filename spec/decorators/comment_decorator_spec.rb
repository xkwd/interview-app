require 'rails_helper'

RSpec.describe CommentDecorator do
  let(:comment) { create(:comment) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let!(:positive_rating) { create(:rating, positive: true, user: user1, comment: comment) }
  let!(:negative_rating) { create(:rating, positive: false, user: user2, comment: comment) }
  let(:decorated_comment) { described_class.new(comment) }

  describe '#upvotes' do
    it 'shows correct count of upvotes' do
      expect(decorated_comment.upvotes)
        .to eq(1)
    end
  end

  describe '#downvotes' do
    it 'shows correct count of upvotes' do
      expect(decorated_comment.downvotes)
        .to eq(1)
    end
  end
end
