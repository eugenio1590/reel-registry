require 'jwt'

module AuthToken
  def generate_auth_token(id)
    payload = { user_id: id, exp: Time.now.to_i + 20.minutes }
    JWT.encode(payload, secret_key_base)
  end

  def parse_auth_token(token)
    JWT.decode(token, secret_key_base)&.first
  end

  def secret_key_base
    ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end
end
