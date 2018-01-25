# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text
#  commentable_type :string
#  commentable_id   :integer
#  user_id          :integer
#  commenter_name   :string
#  commenter_email  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_user_id  (user_id)
#

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
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_db_index(:user_id) }

  it "is valid for guest user" do
    expect(anonymous_comment).to be_valid
  end

  it "is valid for registered user" do
    expect(user_comment).to be_valid
  end
end
