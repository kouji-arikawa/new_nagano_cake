class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genres_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genres_params)
    redirect_to edit_admin_genre_path(genre.id)
  end

private
  def genres_params
    params.require(:genre).permit(:name)
  end
end
