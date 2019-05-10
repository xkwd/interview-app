class Answer < ApplicationRecord
  belongs_to :interview
  belongs_to :section

  validates :content, presence: true
  
  accepts_nested_attributes_for :section

  mount_uploader :image, AnswerImageUploader
end
