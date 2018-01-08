require 'rails_helper'

RSpec.describe InterviewsController, type: :controller do

  describe InterviewsController do
    it { should route(:get, '/interviews').to(action: :index) }
    it { should route(:get, '/interviews/1').to(action: :show, id: 1) }
    it { should route(:get, '/interviews/1').to(action: :show, id: 1) }
    it { should route(:get, '/my_interviews').to(action: :user_interview) }
    it { should use_before_action(:authenticate_user!) }
  end

  describe "logged user" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get index" do
      get 'index'
      expect(response).to be_success
    end
  end

end
