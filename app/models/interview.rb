class Interview < ApplicationRecord
  extend FriendlyId

  has_many :answers
  has_many :sections, through: :answers
  has_many :comments, as: :commentable, dependent: :destroy

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
