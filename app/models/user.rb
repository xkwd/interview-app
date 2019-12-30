class User < ApplicationRecord
  has_many :interviews
  has_many :comments
  has_many :ratings

  validates :name, :email, presence: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
