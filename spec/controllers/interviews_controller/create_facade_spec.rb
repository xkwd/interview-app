require 'rails_helper'

describe InterviewsController::CreateFacade do
  let(:facade) { described_class.new(params, user_id) }
  let(:interview) { instance_double(Interview) }
  let(:user_id) { 4 }

  let(:params) do
    ActionController::Parameters.new(
      interview: {
        title: 'new title'
      }
    )
  end

  let(:received_params) do
    ActionController::Parameters.new(
      title: 'new title',
      user_id: user_id
    )
  end

  before do
    allow(Interview).to receive_messages(new: interview)
    allow(interview).to receive_messages(save: true)
  end

  describe '#interview' do
    it 'returns an interview' do
      facade.interview

      expect(Interview)
        .to have_received(:new)
        .with(received_params.permit!)
    end
  end

  describe '#save' do
    it 'saves an interview' do
      facade.save

      expect(interview)
        .to have_received(:save)
    end
  end
end
