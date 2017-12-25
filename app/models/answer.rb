# == Schema Information
#
# Table name: answers
#
#  id           :integer          not null, primary key
#  content      :text
#  interview_id :integer
#  section_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_answers_on_interview_id  (interview_id)
#  index_answers_on_section_id    (section_id)
#

class Answer < ApplicationRecord
  belongs_to :interview
  belongs_to :section
end
