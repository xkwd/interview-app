# == Schema Information
#
# Table name: interviews
#
#  id           :integer          not null, primary key
#  title        :string
#  published_at :datetime
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  country_id   :integer
#  published    :boolean          default(FALSE)
#
# Indexes
#
#  index_interviews_on_country_id  (country_id)
#  index_interviews_on_user_id     (user_id)
#

class Interview < ApplicationRecord
  has_many :answers
  has_many :sections, through: :answers
  belongs_to :user
  belongs_to :country
  validates :title, :description, presence: true
  accepts_nested_attributes_for :answers, :sections

  scope :published, -> { where(published: true) }
end
