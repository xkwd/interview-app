class Interview < ApplicationRecord
  has_many :answers
  has_many :sections, through :answers
end
