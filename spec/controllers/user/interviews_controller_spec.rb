require 'rails_helper'

describe User::InterviewsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    let(:klass) { described_class::IndexFacade }
    let(:facade) { instance_double(klass) }

    before do
      allow(klass).to receive_messages(new: facade)
    end

    it 'renders index action' do
      get :index

      expect(assigns(:facade)).to eq facade
      expect(response).to have_http_status(:ok)
      expect(klass).to have_received(:new).with(anything)
    end
  end
end
