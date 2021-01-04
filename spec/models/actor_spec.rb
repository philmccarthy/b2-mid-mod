require 'rails_helper'

RSpec.describe Actor, type: :model do
  describe 'relationships' do
    it { should have_many :movie_actors }
    it { should have_many(:movies).through(:movie_actors) }
  end

  describe 'scopes' do
    before(:each) do
      @fox = Actor.create!(name: 'Jamie Fox', age: 53)
      @fey = Actor.create!(name: 'Tina Fey', age: 50)
    end

    it 'avg_age' do
      expect(Actor.avg_age).to eq((@fox.age.to_f + @fey.age) / 2)
    end

    it 'order_by_age' do
      expect(Actor.order_by_age.first).to eq(@fey)
      expect(Actor.order_by_age.last).to eq(@fox)
    end
  end
end