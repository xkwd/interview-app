# == Schema Information
#
# Table name: answers
#
#  id           :bigint(8)        not null, primary key
#  content      :text             not null
#  interview_id :integer
#  section_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  image        :string
#
# Indexes
#
#  index_answers_on_interview_id  (interview_id)
#  index_answers_on_section_id    (section_id)
#

class Answer < ApplicationRecord
  belongs_to :interview
  belongs_to :section
  validates :content, presence: true
  accepts_nested_attributes_for :section

  mount_uploader :image, AnswerImageUploader
end
