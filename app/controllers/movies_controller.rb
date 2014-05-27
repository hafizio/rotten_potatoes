class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :filter_rating, only: :index

  def index
    if params[:sort_by] == 'title'
      @movies = Movie.sort_title
    elsif
      params[:sort_by] == 'release_date'
      @movies = Movie.sort_release_date
    else
      @movies = Movie.all
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "#{@movie.title} was successfully created."
    else
      render :new
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "#{@movie.title} was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, notice: "#{@movie.title} was successfully destroyed."
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
  
    def filter_rating
      @all_ratings = Movie.all_ratings
    end
end
