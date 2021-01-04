class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def self.uniq_actor_names(actor_name)
    joins(:actors)
      .where.not('actors.name = ?', actor_name)
      .select('actors.name')
      .distinct
      .pluck('actors.name')
  end
end
