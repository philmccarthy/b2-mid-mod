class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  scope :order_by_age, -> { order(age: :asc) }
  scope :avg_age, -> { average(:age) }
end
