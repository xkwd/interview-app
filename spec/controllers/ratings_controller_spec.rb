require 'rails_helper'

describe RatingsController, type: :controller do
  describe 'POST #create' do
    let(:klass) { described_class::CreateFacade }
    let(:facade) { instance_double(klass) }
    let(:user) { instance_double(User, id: 14) }

    let(:params) do
      {
        interview_id: 4,
        comment_id: 7
      }
    end

    before do
      allow(controller).to receive(:current_or_guest_user).and_return(user)
      allow(klass).to receive_messages(call: facade)
    end

    it 'renders create action' do
      post :create, xhr: true, params: params

      expect(assigns(:facade)).to eq facade
      expect(response).to have_http_status(:ok)
      expect(klass).to have_received(:call).with(anything, 14)
    end
  end
end
