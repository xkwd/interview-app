require 'rails_helper'

RSpec.describe Interview, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
