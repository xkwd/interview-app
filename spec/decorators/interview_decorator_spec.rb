require 'rails_helper'

RSpec.describe InterviewDecorator do
  let(:interview) { create(:interview, published: published) }
  let(:published) { true }
  let(:decorated_interview) { described_class.decorate(interview) }

  describe '#publication_status' do
    context 'when interview has been published' do
      it 'returns correct publication status' do
        expect(decorated_interview.publication_status)
          .to eq("Published at #{interview.created_at.strftime("%A, %B %e")}")
      end
    end

    context 'when interview has not been published' do
      let(:published) { false }

      it 'returns correct publication status' do
        expect(decorated_interview.publication_status).to eq('Unpublished')
      end
    end
  end

  describe '#published_at' do
    it 'returns correct published_at date' do
      expect(decorated_interview.published_at)
        .to eq("#{interview.created_at.strftime("%A, %B %e")}")
    end
  end
end
