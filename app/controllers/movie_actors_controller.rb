class MovieActorsController < ApplicationController
  def create
    MovieActor.create!(movie_id: params[:movie_id], actor: Actor.by_name(params[:actor_name]))
    redirect_to movie_path(params[:movie_id])
  end
end