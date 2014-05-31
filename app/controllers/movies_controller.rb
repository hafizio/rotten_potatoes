class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :all_ratings, only: :index
  
  def index
    if params[:sort_by].blank? && session[:sorted_by].present?
      flash.keep
      redirect_to movies_path sort_by: sorted_by, ratings: selected_ratings
      return
    end
    
    if params[:ratings].blank? && session[:selected_ratings].present?
      flash.keep
      redirect_to movies_path sort_by: sorted_by, ratings: selected_ratings
      return
    end
    
    @sorted_by = params[:sort_by]
    @selected_ratings = params[:ratings] ? params[:ratings].keys : @all_ratings
    
    session[:sorted_by] = params[:sort_by]
    session[:selected_ratings] = params[:ratings]
    
    @movies = Movie.where(rating: @selected_ratings).order @sorted_by
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
  
    def all_ratings
      @all_ratings = Movie.all_ratings
    end
  
    def sorted_by
      params[:sort_by] || session[:sorted_by]
    end
  
    def selected_ratings
      params[:ratings] || session[:selected_ratings] || []
    end
end
