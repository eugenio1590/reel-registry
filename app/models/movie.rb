class Movie < ApplicationRecord
  validates :title, presence: true
  validates :release_at, presence: true
  validates :director, presence: true
  validates :genre, presence: true
  validates :synopsis, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
end
