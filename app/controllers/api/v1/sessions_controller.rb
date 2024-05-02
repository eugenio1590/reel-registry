class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    return render json: { error: "The email provided is not registered" }, status: :unprocessable_entity if user.blank?

    if user.authenticate(params[:password])
      auth_token = generate_auth_token(user)
      render json: user, auth_token: auth_token
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def generate_auth_token(user)
    payload = { user_id: user.id, exp: Time.now.to_i + 20.minutes }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
