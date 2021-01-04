require 'rails_helper'

RSpec.describe 'actor show page', type: :feature do
  describe 'as a visitor' do
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

    it 'I see that actors name and age and a unique list of actors they have worked with' do
      visit actor_path(@fox)

      expect(page).to have_content(@fox.name)
      expect(page).to have_content(@fox.age)
      expect(page).to have_content(@fey.name, count: 1)
      expect(page).to have_content(@quest.name)
      expect(page).to_not have_content(@hanks.name)
    end
  end
end