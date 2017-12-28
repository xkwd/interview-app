require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of(:content) }
  it { should belong_to(:interview) }
  it { should belong_to(:section) }
end
