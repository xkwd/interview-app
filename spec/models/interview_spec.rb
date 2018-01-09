# == Schema Information
#
# Table name: interviews
#
#  id           :integer          not null, primary key
#  title        :string
#  published_at :datetime
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  country_id   :integer
#
# Indexes
#
#  index_interviews_on_country_id  (country_id)
#  index_interviews_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Interview, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:answers) }
  it { should have_many(:sections).through(:answers) }
  it { should belong_to(:user) }
  it { should belong_to(:country) }
  it { should accept_nested_attributes_for(:answers) }
end
