require 'rails_helper'

RSpec.describe Interview, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:answers) }
  it { should have_many(:sections) }
  it { should belong_to(:user) }
end
