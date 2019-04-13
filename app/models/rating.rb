# == Schema Information
#
# Table name: ratings
#
#  id         :bigint(8)        not null, primary key
#  positive   :boolean          not null
#  user_id    :bigint(8)        not null
#  comment_id :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ratings_on_comment_id  (comment_id)
#  index_ratings_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (user_id => users.id)
#

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates_uniqueness_of :user_id, scope: :comment_id,
                                    message: "Only a single upvote is allowed per user"
end
