require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should have_db_index(:interview_id) }
  it { should have_db_index(:section_id) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:interview) }
  it { should belong_to(:section) }
  it { should accept_nested_attributes_for(:section) }
end
