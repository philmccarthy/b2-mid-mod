require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'relationships' do
    it { should belong_to :studio }
    it { should have_many :movie_actors }
    it { should have_many(:actors).through(:movie_actors) }
  end

  describe 'class methods' do
    before(:each) do
      Studio.destroy_all
      Movie.destroy_all
      MovieActor.destroy_all

      @studio_1 = Studio.create!(name: 'Pixar', location: 'California')

      @m1 = @studio_1.movies.create!(title: 'Soul', creation_year: 2020, genre: 'Animation')
      @m2 = @studio_1.movies.create!(title: 'A Real Movie', creation_year: 2017, genre: 'Romance')
      @m3 = @studio_1.movies.create!(title: 'Toy Story', creation_year: 1995, genre: 'Animation')

      @fox = Actor.create!(name: 'Jamie Fox', age: 53)
      @fey = Actor.create!(name: 'Tina Fey', age: 50)
      @quest = Actor.create!(name: 'Questlove', age: 49)
      @hanks = Actor.create!(name: 'Tom Hanks', age: 64)

      MovieActor.create!(movie: @m1, actor: @fox)
      MovieActor.create!(movie: @m1, actor: @fey)
      MovieActor.create!(movie: @m1, actor: @quest)
      MovieActor.create!(movie: @m2, actor: @fox)
      MovieActor.create!(movie: @m2, actor: @fey)
      MovieActor.create!(movie: @m3, actor: @hanks)
    end

    it '::uniq_actor_names' do
      worked_with = @fox.movies.uniq_actor_names(@fox.name)
      expect(worked_with).to eq(["Questlove", "Tina Fey"])
    end
  end
end