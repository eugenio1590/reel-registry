class Api::V1::MoviesController < ApplicationController
  include Authentication
  include Pagination

  def index
    movies = policy_scope(Movie).page(page).per(per_page)
    options = { meta: pagination_info(movies) }
    render json: Api::V1::MovieSerializer.new(movies, options).serializable_hash
  end
end
