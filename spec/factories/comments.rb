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

FactoryBot.define do
  factory :comment do
    body "MyText"
    commentable_type "MyString"
    commentable_id 1
    user nil
    commenter_name "MyString"
    commenter_email "MyString"
  end
end
