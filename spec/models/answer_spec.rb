# == Schema Information
#
# Table name: answers
#
#  id           :integer          not null, primary key
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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should have_db_index(:interview_id) }
  it { should have_db_index(:section_id) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:interview) }
  it { should belong_to(:section) }
  it { should accept_nested_attributes_for(:section) }
end
