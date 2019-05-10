require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:interviews) }
  it { should have_many(:comments) }
  it { should have_many(:ratings) }
end
