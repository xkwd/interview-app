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

class Section < ApplicationRecord
  validates :name, presence: true
end
