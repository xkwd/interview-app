require 'rails_helper'

describe Answer, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { should have_db_index(:interview_id) }
      it { should have_db_index(:section_id) }
    end
  end

  describe 'relations' do
    it { should belong_to(:interview) }
    it { should belong_to(:section) }

    it { should accept_nested_attributes_for(:section) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end
end
