class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates_uniqueness_of :user_id, scope: :comment_id,
                                    message: 'Only a single upvote is allowed per user'
end
