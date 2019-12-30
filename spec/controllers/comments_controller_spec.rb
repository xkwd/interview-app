require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:klass) { described_class::CreateFacade }
    let(:facade) { instance_double(klass) }
    let(:params) { { interview_id: 5, comment: :comment_attributes } }

    before do
      allow(klass).to receive_messages(new: facade)
      allow(facade).to receive_messages(save: true)
    end

    it 'renders create action' do
      post :create, xhr: true, params: params

      expect(assigns(:facade)).to eq facade
      expect(response).to have_http_status(:ok)
      expect(klass).to have_received(:new).with(anything)
    end
  end
end
