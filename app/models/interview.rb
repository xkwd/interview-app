# == Schema Information
#
# Table name: interviews
#
#  id               :integer          not null, primary key
#  title            :string
#  published_at     :datetime
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  country_id       :integer
#  published        :boolean          default(FALSE)
#  slug             :string
#  cover            :string
#  meta_title       :string
#  meta_description :string
#
# Indexes
#
#  index_interviews_on_country_id  (country_id)
#  index_interviews_on_slug        (slug) UNIQUE
#  index_interviews_on_user_id     (user_id)
#

class Interview < ApplicationRecord
  extend FriendlyId
  has_many :answers
  has_many :sections, through: :answers
  has_many :comments, as: :commentable
  belongs_to :user
  belongs_to :country
  validates :title, :description, presence: true
  validates :meta_title, length: { maximum: 70 }
  validates :meta_description, length: { maximum: 160 }
  accepts_nested_attributes_for :answers, :sections

  friendly_id :title, use: [:slugged, :finders]

  mount_uploader :cover, CoverUploader

  scope :published, -> { where(published: true) }
end
