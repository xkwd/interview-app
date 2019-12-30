require 'rails_helper'

describe Section, type: :model do
  describe 'validatins' do
    it { should validate_presence_of(:name) }
  end
end
