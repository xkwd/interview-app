class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :ratings

  validates :body, presence: true
  validates :commenter_name, :commenter_email, presence: true, unless: :user_id
  validates :user_id, presence: true, unless: :commenter_name
end
