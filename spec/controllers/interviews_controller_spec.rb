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

  describe "GET #new" do
    before do
      sign_in user
    end

    it "assigns a new Interview to @interview" do
      get :new
      expect(assigns(:interview)).to be_a_new(Interview)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    before do
      sign_in user
    end

    context "with valid attributes" do

      it "saves the new interview in the database" do
        # binding.pry
        expect{ post :create, params: { interview: interview.attributes } }.to change(Interview, :count).by(1)
      end

      it "redirects to interviews#show" do
        post :create, params: { interview: interview.attributes }
        expect(response).to redirect_to my_interviews_path
      end
    end

    context "with invalid attributes" do
      it "does NOT save the new interview in the database" do
        expect{ post :create, params: { interview: invalid_interview.attributes } }.not_to change(Interview, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { interview: invalid_interview.attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before do
      sign_in user1
    end

    it "assigns the requested interview to @interview" do
      get :edit, params: { id: interview1 }
      expect(assigns(:interview)).to eq interview1
    end

    it "renders the :edit template" do
      get :edit, params: { id: interview1 }
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    before do
      @interview = create(:interview, title: "Incorrect title")
    end

    context "valid attributes" do
      it "locates the requested @interview" do
        patch :update, params: { id: @interview, interview: attributes_for(:interview) }
        expect(assigns(:contact)).to eq(@contact)
      end

      it "changes @interview's attributes" do
        patch :update, params: { id: @interview, interview: attributes_for(:interview, title: "Correct title") }
        @interview.reload
        expect(@interview.title).to eq("Correct title")
      end

      it "redirects to the updated interview" do
        patch :update, params: { id: @interview, interview: attributes_for(:interview) }
        expect(response).to redirect_to @interview
      end
    end

    context "invalid attributes" do
      it "does NOT change the interview attributes" do
        patch :update, params: { id: @interview, interview: attributes_for(:interview, title: nil, description: "") }
        @interview.reload
        expect(@interview.title).not_to eq(nil)
        expect(@interview.description).not_to eq("")
      end

      it "re-renders the :edit template" do
        patch :update, params: { id: @interview, interview: attributes_for(:interview, title: nil, description: "") }
        expect(response).to render_template :edit
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
