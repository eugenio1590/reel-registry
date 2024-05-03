class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.valid? && user.save
      render json: Api::V1::UserSerializer.new(user).serializable_hash, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
