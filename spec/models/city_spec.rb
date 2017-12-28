require 'rails_helper'

RSpec.describe City, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:country) }
end
