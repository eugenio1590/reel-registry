class ApplicationController < ActionController::API
  include Pundit::Authorization

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_found
    head :not_found
  end

  def not_authorized(e)
    render json: { errors: ["not allowed to #{e.query.chomp('?')} this movie"] }, status: :forbidden
  end
end
