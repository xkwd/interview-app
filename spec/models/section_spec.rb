# == Schema Information
#
# Table name: sections
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  order       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Section, type: :model do
  it { should validate_presence_of(:name) }
end
