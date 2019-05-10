require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:interview) { FactoryBot.create(:interview) }
  let(:anonymous_comment) { FactoryBot.create(:comment, user_id: nil) }
  let(:user_comment) { FactoryBot.create(:comment, commenter_name: nil, commenter_email: nil) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commenter_name) }
  it { should validate_presence_of(:commenter_email) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:commentable) }
  it { should belong_to(:user).without_validating_presence }
  it { should have_many(:comments) }
  it { should have_many(:ratings) }
  it { should have_db_index(:user_id) }

  it "is valid for guest user" do
    expect(anonymous_comment).to be_valid
  end

  it "is valid for registered user" do
    expect(user_comment).to be_valid
  end
end
