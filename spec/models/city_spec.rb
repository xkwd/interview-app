require 'rails_helper'

describe City, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { should have_db_index(:country_id) }
    end
  end

  describe 'relations' do
    it { should belong_to(:country) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
