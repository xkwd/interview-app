# == Schema Information
#
# Table name: countries
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:cities) }
end
