require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do
  let(:user) { create(:user) }

  before do
    allow(klass).to receive_messages(new: facade)
  end

  describe 'GET #index' do
    let(:klass) { described_class::IndexFacade }
    let(:facade) { instance_double(klass) }

    context 'without a search query' do
      it 'renders index action' do
        get :index

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:ok)
        expect(klass).to have_received(:new).with(anything, anything)
      end
    end

    context 'with a search query' do
      let(:params) do
        {
          q: {
            title_or_description_or_answers_content_cont: 'yellow'
          }
        }
      end

      it 'renders index action' do
        post :index, params: params

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:ok)
        expect(klass).to have_received(:new).with(anything, anything)
      end
    end
  end

  describe 'GET #show' do
    let(:klass) { described_class::ShowFacade }
    let(:facade) { instance_double(klass) }
    let(:params) { { id: 4 } }

    it 'renders show action' do
      get :show, params: params

      expect(assigns(:facade)).to eq facade
      expect(response).to have_http_status(:ok)
      expect(klass).to have_received(:new).with(anything)
    end
  end

  describe 'GET #new' do
    let(:klass) { described_class::NewFacade }
    let(:facade) { instance_double(klass) }

    before do
      sign_in user
    end

    it 'renders new action' do
      get :new

      expect(assigns(:facade)).to eq facade
      expect(response).to have_http_status(:ok)
      expect(klass).to have_received(:new).with(user.id)
    end
  end

  describe 'POST #create' do
    let(:klass) { described_class::CreateFacade }
    let(:facade) { instance_double(klass) }
    let(:params) { { title: 'title' } }

    before do
      allow(facade).to receive_messages(save: save)

      sign_in user
    end

    context 'with valid attributes' do
      let(:save) { true }

      it 'redirects to user interviews' do
        post :create, params: params

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:redirect)
        expect(klass)
          .to have_received(:new)
          .with(hash_including('title'), user.id)
      end
    end

    context 'with invalid attributes' do
      let(:save) { false }

      it 'renders new action' do
        post :create, params: params

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:ok)
        expect(klass)
          .to have_received(:new)
          .with(hash_including('title'), user.id)
      end
    end
  end

  describe 'GET #edit' do
    let(:klass) { described_class::EditFacade }
    let(:facade) { instance_double(klass) }

    before do
      allow(facade).to receive_messages(authorized?: authorized?)

      sign_in user
    end

    context 'when authorized to edit' do
      let(:authorized?) { true }

      it 'renders edit action' do
        get :edit, params: { id: '2' }

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:ok)
        expect(klass).to have_received(:new).with('2', user.id)
      end
    end

    context 'when NOT authorized to edit' do
      let(:authorized?) { false }

      it 'renders edit action' do
        get :edit, params: { id: '2' }

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:redirect)
        expect(klass).to have_received(:new).with('2', user.id)
      end
    end
  end

  describe 'PATCH #update' do
    let(:klass) { described_class::UpdateFacade }
    let(:facade) { instance_double(klass) }

    let(:params) do
      {
        id: '2',
        interview: {
          description: 'updated'
        }
      }
    end

    before do
      allow(facade).to receive_messages(save: save)

      sign_in user
    end

    context 'with valid attributes' do
      let(:save) { true }

      it 'redirects to user interviews' do
        patch :update, params: params

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:redirect)
        expect(klass).to have_received(:new).with(anything)
      end
    end

    context 'with invalid attributes' do
      let(:save) { false }

      it 'renders edit action' do
        patch :update, params: params

        expect(assigns(:facade)).to eq facade
        expect(response).to have_http_status(:ok)
        expect(klass).to have_received(:new).with(anything)
      end
    end
  end
end
