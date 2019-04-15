# == Schema Information
#
# Table name: comments
#
#  id               :bigint(8)        not null, primary key
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
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :ratings
  validates :body, presence: true
  validates :commenter_name, :commenter_email, presence: true, unless: :user_id
  validates :user_id, presence: true, unless: :commenter_name

  def upvoted_by?(user)
    ratings.where(positive: true, user: user).present?
  end

  def downvoted_by?(user)
    ratings.where(positive: false, user: user).present?
  end
end
