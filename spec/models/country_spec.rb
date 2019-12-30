require 'rails_helper'

describe Country, type: :model do
  describe 'relations' do
    it { should have_many(:cities) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
