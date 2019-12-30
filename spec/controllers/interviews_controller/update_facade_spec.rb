require 'rails_helper'

describe InterviewsController::UpdateFacade do
  let(:facade) { described_class.new(params) }
  let(:interview) { instance_double(Interview) }

  let(:params) do
    ActionController::Parameters.new(
      id: 2,
      interview: {
        title: 'new title'
      }
    )
  end

  let(:received_params) do
    ActionController::Parameters.new(title: 'new title')
  end

  before do
    allow(Interview).to receive_messages(find: interview)
    allow(interview).to receive_messages(update!: true)
  end

  describe '#interview' do
    it 'returns an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:find)
        .with(2)
    end
  end

  describe '#save' do
    it 'updates an interview' do
      facade.save

      expect(interview)
        .to have_received(:update!)
        .with(received_params.permit!)
    end
  end
end
