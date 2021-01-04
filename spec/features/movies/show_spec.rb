require 'rails_helper'

RSpec.describe 'movie show page', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      Studio.destroy_all
      Movie.destroy_all
      MovieActor.destroy_all
      @studio_1 = Studio.create!(name: 'Pixar', location: 'California')
      @m1 = @studio_1.movies.create!(title: 'Soul', creation_year: 2020, genre: 'Animation')
      @fox = Actor.create!(name: 'Jamie Fox', age: 53)
      @fey = Actor.create!(name: 'Tina Fey', age: 50)
      MovieActor.create!(movie: @m1, actor: @fox)
      MovieActor.create!(movie: @m1, actor: @fey)
    end

    it 'I see the movie title, creation year, and genre, and a list of all its actors from youngest to oldest' do
      visit movie_path(@m1)
      
      expect(page).to have_content(@m1.title)
      expect(page).to have_content(@m1.creation_year)
      expect(page).to have_content(@m1.genre)
      expect(page).to have_content("#{@fox.name}, age: #{@fox.age}")
      expect(page).to have_content("#{@fey.name}, age: #{@fey.age}")
      expect(@fey.name).to appear_before(@fox.name)
      expect(page).to have_content(@m1.actors.avg_age)
    end
  end
end