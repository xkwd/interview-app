class Country < ApplicationRecord
  has_many :cities
  has_many :interviews
  
  validates :name, presence: true
end
