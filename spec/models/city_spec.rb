require 'rails_helper'

RSpec.describe City, type: :model do
  it { should have_db_index(:country_id) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:country) }
end
