require 'rails_helper'

describe Comment, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { should have_db_index(:user_id) }
    end
  end

  describe 'relations' do
    it { should belong_to(:commentable) }
    it { should belong_to(:user).without_validating_presence }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:ratings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:commenter_name) }
    it { should validate_presence_of(:commenter_email) }
    it { should validate_presence_of(:user_id) }

    context 'when created by a guest user' do
      let(:anonymous_comment) { create(:comment, user_id: nil) }

      it 'does NOT validate user_id' do
        expect(anonymous_comment).to be_valid
      end
    end

    context 'when created by a registered user' do
      let(:user_comment) { create(:comment, commenter_name: nil, commenter_email: nil) }

      it 'does NOT validate commenter name/email' do
        expect(user_comment).to be_valid
      end
    end
  end
end
