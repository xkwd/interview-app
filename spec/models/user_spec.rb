require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relations' do
    it { should have_many(:interviews) }
    it { should have_many(:comments) }
    it { should have_many(:ratings) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end
end
