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

    it 'I see a form to add an actors name to the movie and when I fill in the form with an existing actor name I am redirected back to that movie show page And I see the actor name listed' do
      quest = Actor.create!(name: 'Questlove', age: 49)
      visit movie_path(@m1)
      expect(page).to have_content('Add an Actor')

      fill_in 'Add an Actor', with: 'Questlove'
      click_button 'Submit'

      expect(page).to have_content(quest.name)
    end
  end
end