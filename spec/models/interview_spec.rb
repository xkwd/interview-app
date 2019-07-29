require 'rails_helper'

describe Interview, type: :model do
  describe 'db' do
    describe 'indexes' do
      it { should have_db_index(:user_id) }
      it { should have_db_index(:country_id) }
    end
  end

  context 'assotiations' do
    it { should have_many(:answers) }
    it { should have_many(:sections).through(:answers) }
    it { should have_many(:comments).dependent(:destroy) }

    it { should belong_to(:user) }
    it { should belong_to(:country) }

    it { should accept_nested_attributes_for(:answers) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'scopes' do
    describe '.published' do
      before do
        create(:interview, published: true)
        create(:interview, published: false)
        create(:interview, published: true)
      end

      it 'returns only published interviews' do
        expect(Interview.published.count).to eq 2
      end
    end
  end
end
