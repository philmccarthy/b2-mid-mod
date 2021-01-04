Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :studios, only: [:index]
  resources :movies, only: [:show]
  resources :movie_actors, only: [:create]
  resources :actors, only: [:show]
end
