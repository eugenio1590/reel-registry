class Api::V1::MoviesController < ApplicationController
  include Authentication
  include Pagination

  before_action :set_movie, only: [:show, :update, :destroy]

  def index
    movies = policy_scope(Movie).page(page).per(per_page)
    render json: Api::V1::MovieSerializer.new(movies, meta: pagination_info(movies)).serializable_hash
  end

  def show
    render_movie(@movie)
  end

  def create
    movie = Movie.new(movie_params)
    authorize movie
    if movie.save
      render_movie(movie, :created)
    else
      render_errors(movie)
    end
  end

  def update
    authorize @movie
    if @movie.update(movie_params)
      render_movie(@movie)
    else
      render_errors(@movie)
    end
  end

  def destroy
    authorize @movie
    @movie.destroy
    head :no_content
  end

  private

  def movie_params
    params.permit(:title, :release_at, :director, :genre, :synopsis, :duration, :user_id)
  end

  def set_movie
    @movie = policy_scope(Movie).find(params[:id])
  end

  def render_movie(movie, status = :ok)
    render json: Api::V1::MovieSerializer.new(movie).serializable_hash, status: status
  end

  def render_errors(movie)
    render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
  end
end
