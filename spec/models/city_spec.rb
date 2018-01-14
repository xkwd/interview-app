# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#

require 'rails_helper'

RSpec.describe City, type: :model do
  it { should have_db_index(:country_id) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:country) }
end
