require 'rails_helper'

describe CommentDecorator do
  let(:comment) { create(:comment) }
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:decorated_comment) { described_class.new(comment) }

  before do
    create(:rating, positive: true, user: user1, comment: comment)
    create(:rating, positive: false, user: user2, comment: comment)
  end

  describe '#upvotes' do
    it 'shows correct count of upvotes' do
      expect(decorated_comment.upvotes).to eq('1')
    end
  end

  describe '#downvotes' do
    it 'shows correct count of upvotes' do
      expect(decorated_comment.downvotes).to eq('1')
    end
  end

  describe '#upvoted_by?' do
    it 'identifies whether a comment has been upvoted by a given user' do
      expect(decorated_comment.upvoted_by?(user1)).to be(true)
    end
  end

  describe '#downvoted_by?' do
    it 'identifies whether a comment has been downvoted by a given user' do
      expect(decorated_comment.downvoted_by?(user2)).to be(true)
    end
  end
end
