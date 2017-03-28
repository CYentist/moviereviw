class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film

  validates :content, presence: true
  scope :recent, -> { order("created_at DESC")}
end
