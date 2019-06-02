require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do
  let!(:user)  { create(:user) }
  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let(:country) { create(:country) }
  let(:interview) { build(:interview, user: user, country: country) }
  let(:invalid_interview) { build(:interview, title: nil) }
  let!(:interview1) { create(:interview, user: user1, title: "Green yellow blue") }
  let!(:interview2) { create(:interview, user: user1, title: "Green blue") }
  let!(:interview3) { create(:interview, user: user1, title: "Yellow blue") }
  let!(:interview4) { create(:interview, user: user2) }
  let!(:interview5) { create(:interview, user: user2, published: false) }

  it { should route(:get, '/interviews').to(action: :index) }
  it { should route(:get, '/interviews/1').to(action: :show, id: 1) }
  it { should route(:get, '/interviews/1').to(action: :show, id: 1) }
  it { should route(:get, '/my_interviews').to(action: :user_interview) }
  it { should use_before_action(:authenticate_user!) }

  describe "GET #index" do
    it "populates an array of all published interviews" do
      get :index
      expect(assigns(:interviews)).to match_array([interview1, interview2])
    end

    it "does NOT include unpublished interviews" do
      get :index
      expect(assigns(:interviews)).not_to eq interview5
    end

    it "renders the :index template" do
      get 'index'
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:klass) { described_class::ShowFacade }
    let(:facade) { instance_double(klass) }
    let(:params) { { id: 4 } }

    before do
      allow(klass).to receive_messages(new: facade)
    end

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
      allow(klass).to receive_messages(new: facade)

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
      allow(klass).to receive_messages(new: facade)
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
      allow(klass).to receive_messages(new: facade)
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
      allow(klass).to receive_messages(new: facade)
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

  describe "GET user_interview" do
    context "user not signed in" do
      it "redirects not logged user to sign_in" do
        get :user_interview
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user signed in" do
      before do
        sign_in user1
      end

      it "shows current user interviews" do
        get :user_interview
        expect(assigns(:decorated_user_interviews)).to include(interview1, interview2, interview3)
      end

      it "does NOT show interviews of other users" do
        get :user_interview
        expect(assigns(:decorated_user_interviews)).not_to include(interview4, interview5)
      end
    end
  end

  describe "Search interviews" do
    it "gets all interviews matching the key words" do
      get :search, params: { q: { title_or_description_or_answers_content_cont: 'yellow' } }
      expect(assigns(:interviews)).to include(interview1, interview3)
    end

    it "does NOT show interviews not matching the key words" do
      get :search, params: { q: { title_or_description_or_answers_content_cont: 'yellow' } }
      expect(assigns(:interviews)).not_to include(interview2, interview4)
    end
  end
end
