class Film < ApplicationRecord
  has_many :reviews
  belongs_to :user
  
  validates :title, presence: true
end
