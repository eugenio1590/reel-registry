class Api::V1::MoviesController < ApplicationController
  include Authentication
  include Pagination

  def index
    movies = policy_scope(Movie).page(page).per(per_page)
    options = { meta: pagination_info(movies) }
    render json: Api::V1::MovieSerializer.new(movies, options).serializable_hash
  end

  def show
    movie = policy_scope(Movie).find(params[:id])
    render json: Api::V1::MovieSerializer.new(movie).serializable_hash
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def create
    movie = Movie.new(movie_params)
    authorize movie
    if movie.save
      render json: Api::V1::MovieSerializer.new(movie).serializable_hash, status: :created
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Pundit::NotAuthorizedError
    render json: { errors: ["not allowed to create this movie"] }, status: :forbidden
  end

  def update
    movie = policy_scope(Movie).find(params[:id])
    authorize movie
    if movie.update(movie_params)
      render json: Api::V1::MovieSerializer.new(movie).serializable_hash
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def destroy
    movie = policy_scope(Movie).find(params[:id])
    authorize movie
    movie.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    head :not_found
  rescue Pundit::NotAuthorizedError
    render json: { errors: ["not allowed to delete this movie"] }, status: :forbidden
  end

  private

  def movie_params
    params.permit(:title, :release_at, :director, :genre, :synopsis, :duration, :user_id)
  end
end
