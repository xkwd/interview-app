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
#

class Interview < ApplicationRecord
  has_many :answers
  has_many :sections, through: :answers
  belongs_to :user
end
