require 'rails_helper'

RSpec.describe InterviewDecorator do
  let(:decorated_interview) { described_class.new(interview) }
  let(:published?) { true }

  let(:interview) do
    instance_double(
      Interview,
      published?: published?,
      created_at: Time.zone.parse('Wed, 17 Apr 2019 11:00:00'),
      comments: :comments
    )
  end

  describe '#comments' do
    before do
      allow(CommentDecorator)
        .to receive_messages(decorate_collection: :decorated_collection)
    end

    it 'decorates interview comments' do
      decorated_interview.comments

      expect(CommentDecorator)
        .to have_received(:decorate_collection)
        .with(:comments)
    end
  end

  describe '#publication_status' do
    context 'when an interview has been published' do
      it 'returns correct publication status' do
        expect(decorated_interview.publication_status)
          .to eq('Published on Wednesday, April 17, 2019')
      end
    end

    context 'when an interview has not been published' do
      let(:published?) { false }

      it 'returns correct publication status' do
        expect(decorated_interview.publication_status).to eq 'Unpublished'
      end
    end
  end

  describe '#published_at' do
    it 'returns correct published_at date' do
      expect(decorated_interview.published_at)
        .to eq 'Wednesday, April 17, 2019'
    end
  end
end
