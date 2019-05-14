require 'rails_helper'

describe Rating, type: :model do
  describe 'relations' do
    it { should belong_to(:user) }
    it { should belong_to(:comment) }
  end
end
