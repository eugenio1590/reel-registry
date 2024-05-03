class Api::V1::SessionsController < ApplicationController
  include AuthToken
  
  def create
    user = User.find_by(email: params[:email])

    return render json: { error: "The email provided is not registered" }, status: :unprocessable_entity if user.blank?

    if user.authenticate(params[:password])
      auth_token = generate_auth_token(user.id)
      render json: Api::V1::UserSerializer.new(user, meta: { auth_token: auth_token }).serializable_hash
    else
      render json: { errors: [ 'Invalid credentials' ] }, status: :unauthorized
    end
  end
end
