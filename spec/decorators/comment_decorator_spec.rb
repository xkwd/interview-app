require 'rails_helper'

describe CommentDecorator do
  let(:decorator) { described_class.new(comment) }
  let(:user) { instance_double(User, name: 'Jim') }
  let(:commenter_name) { 'Fred' }

  let(:comment) do
    instance_double(
      Comment,
      ratings: Rating,
      comments: :comments,
      created_at: Time.zone.parse('2019-06-22 13:00'),
      user: user,
      commenter_name: commenter_name
    )
  end

  before do
    allow(Rating)
      .to receive_messages(
        where: [:rating1, :rating2],
        find_by: :rating
      )
  end

  describe '#comments' do
    before do
      allow(described_class)
        .to receive_messages(decorate_collection: :decorated_collection)
    end

    it 'decorates comments of a comment' do
      decorator.comments

      expect(described_class)
        .to have_received(:decorate_collection)
        .with(:comments)
    end
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

  describe '#publised_at' do
    it 'returns formatted date' do
      expect(decorator.published_at).to eq '2019-06-22, 13:00'
    end
  end

  describe '#author_name' do
    context 'with a guest user' do
      it 'returns a guest name' do
        expect(decorator.author_name).to eq 'Fred'
      end
    end

    context 'with a registered user' do
      let(:commenter_name) { nil }

      it 'returns a link with a user name' do
        expect(decorator.author_name).to eq '<a href="#">Jim</a>'
      end
    end
  end
end
