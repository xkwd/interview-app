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
    body { Faker::Lorem.paragraphs(rand(1...3)).join }
    commenter_name { Faker::Name.name }
    commenter_email { Faker::Internet.email }

    user
    association :commentable, factory: :interview
  end
end
