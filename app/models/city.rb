# == Schema Information
#
# Table name: cities
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :integer
#
# Indexes
#
#  index_cities_on_country_id  (country_id)
#

class City < ApplicationRecord
  belongs_to :country
  validates :name, presence: true
end
