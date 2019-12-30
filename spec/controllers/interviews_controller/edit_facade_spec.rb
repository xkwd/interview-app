require 'rails_helper'

describe InterviewsController::EditFacade do
  let(:facade) { described_class.new(interview_id, user_id) }
  let(:interview_id) { 2 }
  let(:user_id) { 4 }

  describe '#interview' do
    before do
      allow(Interview).to receive_messages(find: :interview)
    end

    it 'returns an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:find)
        .with(2)
    end
  end

  describe '#authorized?' do
    before do
      allow(Interview).to receive_messages(find: interview)
    end

    context 'when authorized' do
      let(:interview) { instance_double(Interview, user_id: 4) }

      it 'returns true' do
        expect(facade.authorized?).to eq true
      end
    end

    context 'when NOT authorized' do
      let(:interview) { instance_double(Interview, user_id: 7) }

      it 'returns true' do
        expect(facade.authorized?).to eq false
      end
    end
  end
end
