require 'rails_helper'

RSpec.describe InterviewDecorator do
  let(:decorated_interview) { described_class.decorate(interview) }

  let(:interview) do
    build(
      :interview,
      published: published,
      created_at: 'Wed, 17 Apr 2019 11:00:00 UTC +00:00'
    )
  end

  describe '.decorate' do
    before do
      allow(described_class).to receive(:new)
    end

    it 'returns a decorated object' do
      described_class.decorate(:interview)

      expect(described_class).to have_received(:new).with(:interview)
    end
  end

  describe '.decorate_collection' do
    before do
      allow(described_class).to receive_messages(decorate: :interview)
    end

    it 'returns a collection of decorated interviews' do
      described_class.decorate_collection([:interview, :interview])

      expect(described_class).to have_received(:decorate).twice
    end
  end

  describe '#publication_status' do
    context 'when an interview has been published' do
      let(:published) { true }

      it 'returns correct publication status' do
        expect(decorated_interview.publication_status)
          .to eq('Published on Wednesday, April 17, 2019')
      end
    end

    context 'when an interview has not been published' do
      let(:published) { false }

      it 'returns correct publication status' do
        expect(decorated_interview.publication_status).to eq('Unpublished')
      end
    end
  end

  describe '#published_at' do
    let(:published) { true }

    it 'returns correct published_at date' do
      expect(decorated_interview.published_at).to eq('Wednesday, April 17, 2019')
    end
  end
end
