require 'rails_helper'

RSpec.describe InterviewDecorator do
  let(:interview1) { build(:interview, published: published, created_at: timestamp) }
  let(:interview2) { build(:interview, published: published) }
  let(:published) { true }
  let(:timestamp) { 'Wed, 17 Apr 2019 11:00:00 UTC +00:00' }
  let(:decorated_interview) { described_class.decorate(interview1) }

  describe '.decorate' do
    subject { described_class.decorate(interview1) }

    before do
      allow(described_class).to receive(:new)
    end

    it 'returns a decorated object' do
      subject
      expect(described_class).to have_received(:new).with(interview1)
    end
  end

  describe '.decorate_collection' do
    subject { described_class.decorate_collection([interview1, interview2]) }

    before do
      allow(described_class).to receive(:decorate)
    end

    it 'returns a collection of decorated objects' do
      subject
      expect(described_class).to have_received(:decorate).with(interview1)
      expect(described_class).to have_received(:decorate).with(interview2)
    end
  end

  describe '#publication_status' do
    context 'when an interview has been published' do
      it 'returns correct publication status' do
        expect(decorated_interview.publication_status).to eq('Published on Wednesday, April 17, 2019')
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
    it 'returns correct published_at date' do
      expect(decorated_interview.published_at).to eq('Wednesday, April 17, 2019')
    end
  end
end
