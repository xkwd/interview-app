require 'rails_helper'

describe InterviewsController::ShowFacade do
  let(:facade) { described_class.new(params) }
  let(:params) { { id: 4 } }

  describe '#interview' do
    before do
      allow(InterviewDecorator)
        .to receive_messages(new: :decorated_interview)
      allow(Interview)
        .to receive_messages(
          published: Interview,
          find: :interview
        )
    end

    it 'finds an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:find)
        .with(4)
    end

    it 'decorates an interview' do
      facade.interview

      expect(InterviewDecorator)
        .to have_received(:new)
        .with(:interview)
    end
  end
end
