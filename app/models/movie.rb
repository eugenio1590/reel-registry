class Movie < ApplicationRecord
  belongs_to :user, optional: true
  
  validates :title, presence: true
  validates :release_at, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  validates :synopsis, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  scope :shared, -> { where(user_id: nil) }
  scope :owned, ->(user) { where(user_id: user.id) if user.present? }
end
