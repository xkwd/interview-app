require 'rails_helper'

describe CommentDecorator do
  let(:decorator) { described_class.new(comment) }
  let(:comment) { instance_double(Comment, ratings: Rating) }

  before do
    allow(Rating)
      .to receive_messages(
        where: [:rating1, :rating2],
        find_by: :rating
      )
  end

  describe '#upvotes' do
    it 'finds upvotes' do
      decorator.upvotes

      expect(Rating)
        .to have_received(:where)
        .with(positive: true)
    end

    it 'returns upvotes count' do
      expect(decorator.upvotes).to eq '2'
    end
  end

  describe '#downvotes' do
    it 'finds downvotes' do
      decorator.downvotes

      expect(Rating)
        .to have_received(:where)
        .with(positive: false)
    end

    it 'returns downvotes count' do
      expect(decorator.downvotes).to eq '2'
    end
  end

  describe '#upvoted_by?' do
    it 'finds upvotes of a given user' do
      decorator.upvoted_by?(:user)

      expect(Rating)
        .to have_received(:find_by)
        .with(positive: true, user: :user)
    end

    it 'identifies whether a comment has been upvoted by a given user' do
      expect(decorator.upvoted_by?(:user)).to be true
    end
  end

  describe '#downvoted_by?' do
    it 'finds downvotes of a given user' do
      decorator.downvoted_by?(:user)

      expect(Rating)
        .to have_received(:find_by)
        .with(positive: false, user: :user)
    end

    it 'identifies whether a comment has been downvoted by a given user' do
      expect(decorator.downvoted_by?(:user)).to be true
    end
  end
end
