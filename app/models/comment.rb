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

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
end
