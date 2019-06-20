require 'rails_helper'

describe InterviewsController::NewFacade do
  let(:facade) { described_class.new(user_id) }
  let(:user_id) { 4 }

  describe '#interview' do
    before do
      allow(Section).to receive_messages(ids: [1, 2, 3])
      allow(Answer).to receive_messages(new: :answer)
      allow(Interview).to receive_messages(new: :interview)
    end

    it 'builds answers' do
      facade.interview

      expect(Answer)
        .to have_received(:new)
        .with(content: '', section_id: 1)
        .with(content: '', section_id: 2)
        .with(content: '', section_id: 3)
    end

    it 'returns an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:new)
        .with(user_id: 4, answers: [:answer, :answer, :answer])
    end
  end
end
