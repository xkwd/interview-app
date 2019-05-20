require 'rails_helper'

describe InterviewsController::ShowFacade do
  let(:facade) { described_class.new(params) }
  let(:params) { { id: 4 } }

  describe '#interview' do
    before do
      allow(Interview)
        .to receive_messages(
          published: Interview,
          find: :interview
        )
    end

    it 'returns an interview' do
      facade.interview

      expect(Interview).to have_received(:find).with(4)
    end
  end
end
