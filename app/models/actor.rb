class Actor < ApplicationRecord
  has_many :movie_actors
  has_many :movies, through: :movie_actors

  scope :order_by_age, -> { order(age: :asc) }
  scope :avg_age, -> { average(:age) }

  def self.by_name(actor_name)
    where(name: actor_name).first
  end
end
