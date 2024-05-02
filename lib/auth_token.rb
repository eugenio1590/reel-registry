module AuthToken
  def generate_auth_token(user)
    payload = { user_id: user.id, exp: Time.now.to_i + 20.minutes }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
