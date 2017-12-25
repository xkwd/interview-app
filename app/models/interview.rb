class Interview < ApplicationRecord
  has_many :answers
  has_many :sections, through :answers
  belongs_to :user
end
