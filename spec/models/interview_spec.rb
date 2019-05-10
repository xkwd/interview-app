require 'rails_helper'

RSpec.describe Interview, type: :model do
  let!(:interview1) { create(:interview, published: true) }
  let!(:interview2) { create(:interview, published: false) }
  let!(:interview3) { create(:interview, published: true) }

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  context "assotiations" do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:country_id) }
    it { should have_many(:answers) }
    it { should have_many(:sections).through(:answers) }
    it { should belong_to(:user) }
    it { should belong_to(:country) }
    it { should accept_nested_attributes_for(:answers) }
  end

  describe ".published" do
    it "returns published interviews" do
      published_interviews = described_class.published

      expect(published_interviews).to include(interview1)
      expect(published_interviews).to include(interview3)
    end

    it "doesn't return unpublished interviews" do
      expect(described_class.published).not_to include(interview2)
    end
  end
end
