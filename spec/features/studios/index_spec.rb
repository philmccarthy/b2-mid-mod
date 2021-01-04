require 'rails_helper'

RSpec.describe 'studios index page', type: :feature do
  describe 'as a visitor' do
    before(:each) do
      Studio.destroy_all
      Movie.destroy_all

      @studio_1 = Studio.create!(name: 'Pixar', location: 'California')
      @studio_2 = Studio.create!(name: 'Disney', location: 'California')
      @studio_3 = Studio.create!(name: 'Lucasfilm', location: 'California')
      
      @m1 = @studio_1.movies.create!(title: 'Soul', creation_year: 2020, genre: 'Animation')
      @m2 = @studio_1.movies.create!(title: 'Toy Story', creation_year: 1995, genre: 'Animation')
      @m3 = @studio_2.movies.create!(title: 'Johnny Tsunami', creation_year: 1999, genre: 'Family')
      @m4 = @studio_2.movies.create!(title: 'Brink!', creation_year: 1998, genre: 'Sport')
      @m5 = @studio_3.movies.create!(title: 'Star Wars: A New Hope', creation_year: 1977, genre: 'Sci-fi')
      @m6 = @studio_3.movies.create!(title: 'Star Wars: Return of the Jedi', creation_year: 1983, genre: 'Sci-fi')
    end

    it 'i see a list of all of the movie studios and the names of all of its movies' do
      visit studios_path

      within("#studio-#{@studio_1.id}-movies") do
        expect(page).to have_content(@studio_1.name)
        expect(page).to have_content(@m1.title)
        expect(page).to have_content(@m2.title)
      end

      within("#studio-#{@studio_2.id}-movies") do
        expect(page).to have_content(@studio_2.name)
        expect(page).to have_content(@m3.title)
        expect(page).to have_content(@m4.title)
      end
      
      within("#studio-#{@studio_3.id}-movies") do
        expect(page).to have_content(@studio_3.name)
        expect(page).to have_content(@m5.title)
        expect(page).to have_content(@m6.title)
      end
    end
  end
end