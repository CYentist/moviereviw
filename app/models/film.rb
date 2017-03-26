class Film < ApplicationRecord
  has_many :reviews
  belongs_to :user
  validates :title, presence: true
  has_many :film_relationships
  has_many :members, through: :film_relationships, source: :user
end
